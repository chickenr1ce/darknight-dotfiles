# CodeGraph Reference

This project has a CodeGraph MCP server (`cg_*` tools) configured. CodeGraph is a tree-sitter-parsed knowledge graph of every symbol, edge, and file. Reads are sub-millisecond and return structural information grep cannot.

## When to prefer codegraph over native search

Use codegraph for **structural** questions — what calls what, what would break, where is X defined, what is X's signature. Use native grep/read only for **literal text** queries (string contents, comments, log messages) or after you already have a specific file open.

| Question | Tool |
|---|---|
| "Where is X defined?" / "Find symbol named X" | `cg_codegraph_search` |
| "What calls function Y?" | `cg_codegraph_callers` |
| "What does Y call?" | `cg_codegraph_callees` |
| "What would break if I changed Z?" | `cg_codegraph_impact` |
| "Show me Y's signature / source / docstring" | `cg_codegraph_node` |
| "Give me focused context for a task/area" | `cg_codegraph_context` |
| "See several related symbols' source at once" | `cg_codegraph_explore` |
| "What files exist under path/" | `cg_codegraph_files` |
| "Is the index healthy?" | `cg_codegraph_status` |

## Rules of thumb

- **Answer directly — don't delegate exploration.** For "how does X work" / architecture / trace questions, answer with 2-3 codegraph calls: `cg_codegraph_context` first, then ONE `cg_codegraph_explore` for the source of the symbols it surfaces. Codegraph IS the pre-built index, so spawning a separate file-reading sub-task/agent — or running a grep + read loop — repeats work codegraph already did and costs more for the same answer.
- **Trust codegraph results.** They come from a full AST parse. Do NOT re-verify them with grep — that's slower, less accurate, and wastes context.
- **Don't grep first** when looking up a symbol by name. `cg_codegraph_search` is faster and returns kind + location + signature in one call.
- **Don't chain `cg_codegraph_search` + `cg_codegraph_node`** when you just want context — `cg_codegraph_context` is one call.
- **Don't loop `cg_codegraph_node` over many symbols** — one `cg_codegraph_explore` call returns several symbols' source grouped in a single capped call, while each separate node/Read call re-reads the whole context and costs far more.
- **Index lag**: the file watcher debounces ~500ms behind writes; don't re-query immediately after editing a file in the same turn.

## If `.codegraph/` doesn't exist

The index is created with `codegraph init` in the project root when missing (the autoindex plugin is V1-only and does not load on V2). If they still report "not initialized":

- Do not ask the user. Delegate to @executor: run `codegraph init` in the project root (indexing is default in v1.5; no flags needed), wait for it, then retry the cg call.
- If init fails with a stale-lock error, run `codegraph unlock` first, then `codegraph init` again.
- Verify with `codegraph status` (or `codegraph status -j` for JSON).
- If tools still report not initialized after indexing, the cg MCP server was started before the index existed — restart opencode once.

The file watcher keeps the index fresh after init; no manual reindexing day to day. After huge refactors, `codegraph sync` catches anything the watcher missed.
