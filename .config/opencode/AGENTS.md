## Questions

Questions are READ only. Do not edit files when asked a question unless explicitly stated.


<!-- CODEGRAPH_START -->
## CodeGraph

CodeGraph is a tree-sitter knowledge graph of every symbol, edge, and file. For **structural** questions — what calls what, what would break, where X is defined, X's signature — prefer codegraph over grep/read: one call returns verbatim source, call path, and blast radius. Trust its results (full AST parse); do not re-verify with grep. Use native grep/read only for literal-text queries (strings, comments) or already-open files.

**Invocation (Code Mode):** codegraph is an MCP server namespace, NOT a directly callable tool. A bare `cg(...)` call fails with `Unknown tool: cg`. Reach it ONLY inside the `execute` tool's sandbox:

```js
return await tools["cg"]["codegraph_explore"]({
  query: "...",        // symbol/file names or a natural-language question
  maxFiles: 12,        // optional, default 12
  projectPath: "...",  // optional, for querying a second codebase
});
```

If cg reports "not initialized", run `codegraph init` in the project root (via @executor) and retry.

Full reference (usage table, rules of thumb, recovery): ~/.config/opencode/docs/codegraph.md
<!-- CODEGRAPH_END -->

<!-- CAVEMAN_START -->
## Caveman Mode

Caveman mode is opt-in terse speech, activated with `/caveman` (levels: lite, full, ultra, wenyan; `off` to deactivate), the dedicated `/caveman-commit`, `/caveman-review`, `/caveman-compress` commands, or plain language ("activate caveman", "stop caveman", "normal mode").

Only when caveman mode is active (or a caveman command was just invoked):

- Respond terse like smart caveman. Drop articles, filler, pleasantries, hedging. Fragments OK.
- Technical terms exact. Pattern: [thing] [action] [reason]. [next step].
- Code, commit messages, security warnings: normal English, never caveman.

When not active, ignore this section and write normally.
<!-- CAVEMAN_END -->

<!-- GIT_SAFETY_START -->
## Git Safety

Never run `git commit` or `git push` unless the user explicitly asks you to. These commands require explicit user approval — permission rules prompt before they run, and you must not bypass or work around that prompt. If you think a commit or push is warranted, say so and ask first; do not just do it.
<!-- GIT_SAFETY_END -->
