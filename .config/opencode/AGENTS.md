<!-- CODEGRAPH_START -->
## CodeGraph

CodeGraph is a tree-sitter knowledge graph of every symbol, edge, and file (`cg_*` MCP tools). For **structural** questions — what calls what, what would break, where X is defined, X's signature — prefer `cg_codegraph_explore` over grep/read: one call returns verbatim source, call path, and blast radius. Trust its results (full AST parse); do not re-verify with grep. Use native grep/read only for literal-text queries (strings, comments) or already-open files. If cg reports "not initialized", run `codegraph init` in the project root (via @executor) and retry.

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
