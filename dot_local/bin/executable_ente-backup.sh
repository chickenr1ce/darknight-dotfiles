#!/usr/bin/env bash
# Back up the Ente self-hosted instance from the Pi into two restic repos:
#   local     ~/Storage/ente-restic         fast restore
#   off-site  rclone:gdrive:ente-restic     survives the house
#
# Runs on the desktop. rsync pulls a local stage copy from the Pi, then
# restic snapshots the stage, so the 2 GB Pi does no backup work.
#
# The bundle is deliberately three things, all required for a restore:
#   - the object store (/mnt/ente/minio)
#   - the instance config, including museum.yaml with key.encryption/jwt.secret
#   - a consistent pg_dump (holds the per-file encryption keys)
# Lose the config or the database and the blobs are unreadable.

set -euo pipefail

export RESTIC_PASSWORD_FILE="$HOME/.config/restic/ente-password"
# `restic copy` reads the source repo with its own variable, so set both.
# Both repos use the same password file.
export RESTIC_FROM_PASSWORD_FILE="$HOME/.config/restic/ente-password"

REPO_LOCAL="$HOME/Storage/ente-restic"
REPO_OFFSITE="rclone:gdrive:ente-restic"
PI="buarli@100.98.96.99"
PI_STAGE="/home/buarli/ente-backup"
STAGE="$HOME/Storage/ente-stage"
LOG="$HOME/.local/state/ente-backup/restic.log"

mkdir -p "$(dirname "$LOG")" "$STAGE"
exec >>"$LOG" 2>&1
echo "=== run $(date -Is) ==="

# 1. Consistent DB dump + config copy, produced on the Pi.
ssh -o BatchMode=yes "$PI" "
  set -e
  mkdir -p $PI_STAGE
  cp /home/buarli/my-ente/museum.yaml $PI_STAGE/museum.yaml
  docker exec my-ente-postgres-1 pg_dump -U pguser -Fc ente_db > $PI_STAGE/db.dump
  ls -l $PI_STAGE
"

# 2. Stage a local copy of the three pieces.
rsync -a --delete -e 'ssh -o BatchMode=yes' "$PI:/mnt/ente/minio/"   "$STAGE/minio/"
rsync -a --delete -e 'ssh -o BatchMode=yes' "$PI:/home/buarli/my-ente/" "$STAGE/my-ente/"
rsync -a           -e 'ssh -o BatchMode=yes' "$PI:$PI_STAGE/db.dump"  "$STAGE/db.dump"

# 3. Clear stale locks left by an interrupted run (a reboot mid-copy is the
#    usual cause), but never yank a lock from a run that is actually live.
if ! pgrep -x restic >/dev/null; then
  restic unlock --repo "$REPO_LOCAL"   >/dev/null 2>&1 || true
  restic unlock --repo "$REPO_OFFSITE" >/dev/null 2>&1 || true
fi

# 4. Snapshot the stage into the local repo.
restic backup --repo "$REPO_LOCAL" --host pi-ente --tag ente "$STAGE"

# 5. Mirror the new snapshots off-site.
restic copy --repo "$REPO_OFFSITE" --from-repo "$REPO_LOCAL"

# 6. Retention on both repos.
restic forget --repo "$REPO_LOCAL"   --prune --keep-daily 7 --keep-weekly 4 --keep-monthly 6
restic forget --repo "$REPO_OFFSITE" --prune --keep-daily 7 --keep-weekly 4 --keep-monthly 6

echo "=== done $(date -Is) ==="
