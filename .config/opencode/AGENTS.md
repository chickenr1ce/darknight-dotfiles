## Questions

Questions are READ only. Do not edit files when asked a question unless explicitly stated.

## Shell

The agent's shell tool runs bash (`$0` is `/usr/bin/bash`): POSIX syntax, heredocs, `$?`, and globs all work there. This section only applies to commands the user will paste into their own terminal, which is fish.

The user's interactive shell is fish, not bash. POSIX-only syntax fails there: heredocs (`<<'EOF'`), `VAR=$!`, `$?`, and unmatched globs (fish errors instead of passing them through). For a command the user runs in fish, wrap it in `bash -c '...'` — or better, write a script file and execute it.

## Writing

Load the `unslop` skill at session start and apply it to all prose you write: chat messages, commit messages, docs, and comments. Code, commands, and quoted output stay literal.

## Artifacts

Share local single-file artifacts (HTML, logs, images) as clickable file links. Check browser connectivity before automating the browser.

The browser tool opens `http` and `https` only, so a local `file://` artifact needs a server: run `python3 -m http.server <port> --bind 127.0.0.1` in the artifact's directory and open the loopback URL. Pass the `tabId` from `browser.open` into `browser.capture`; without it, a capture grabs whichever tab the user is viewing rather than the one just opened.

<!-- GIT_SAFETY_START -->
## Git Safety

Never run `git commit` or `git push` unless the user explicitly asks you to. These commands require explicit user approval — permission rules prompt before they run, and you must not bypass or work around that prompt. If you think a commit or push is warranted, say so and ask first; do not just do it.
Invoking a flow whose steps include committing (for example `/implement`) is explicit approval for the commit that flow calls for; you do not need a separate ask. Everything else still needs one.
Before `git push`, list what the push carries with `git log origin/<branch>..HEAD --oneline`. If the branch holds commits beyond the task at hand, stop and ask how to proceed instead of pushing them along.
<!-- GIT_SAFETY_END -->
