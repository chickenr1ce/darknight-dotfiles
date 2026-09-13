## Questions

Questions are READ only. Do not edit files when asked a question unless explicitly stated.

## Shell

The shell is fish, not bash. POSIX-only syntax fails: heredocs (`<<'EOF'`), `VAR=$!`, `$?`, and unmatched globs (fish errors instead of passing them through). For anything beyond simple single commands, wrap in `bash -c '...'` — or better, write a script file and execute it.

## Writing

Load the `unslop` skill at session start and apply it to all prose you write: chat messages, commit messages, docs, and comments. Code, commands, and quoted output stay literal.

<!-- GIT_SAFETY_START -->
## Git Safety

Never run `git commit` or `git push` unless the user explicitly asks you to. These commands require explicit user approval — permission rules prompt before they run, and you must not bypass or work around that prompt. If you think a commit or push is warranted, say so and ask first; do not just do it.
<!-- GIT_SAFETY_END -->
