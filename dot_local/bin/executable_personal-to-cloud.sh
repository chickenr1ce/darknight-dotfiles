#!/usr/bin/env bash
# One-way upload of the `personal` folder to the cloud.
#
# Direction: local -> cloud only. rclone `copy` never deletes at the
# destination, so nothing here can remove or overwrite cloud data destructively.
# The cloud is a restore source, not a second place to edit.
#
# Syncthing owns the local folder; this job only reads it.

set -euo pipefail

SRC="${PERSONAL_SRC:-$HOME/personal}"
DEST="${PERSONAL_DEST:-gdrive:personal}"
LOG="${PERSONAL_LOG:-$HOME/.local/state/personal-sync/rclone.log}"

mkdir -p "$(dirname "$LOG")"

# Exclude Syncthing's own bookkeeping so it never lands in the cloud copy.
rclone copy "$SRC" "$DEST" \
  --exclude ".stfolder/**" \
  --exclude ".stversions/**" \
  --transfers 4 \
  --checkers 8 \
  --log-level INFO \
  --log-file "$LOG"
