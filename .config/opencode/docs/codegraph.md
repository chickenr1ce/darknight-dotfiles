# CodeGraph Reference

CodeGraph is a tree-sitter-parsed knowledge graph of every symbol, edge, and file. Reads are sub-millisecond and return structural information grep cannot.

## Invocation (Code Mode runtime)

Codegraph is exposed as an MCP server named `cg`. In Code Mode it is **NOT a directly callable tool** — a bare `cg(...)` call fails with `Unknown tool: cg`. Reach it ONLY inside the `execute` tool's sandbox:

```js
return await tools["cg"]["codegraph_explore"]({
  query: "...",        // symbol/file names or a natural-language question
  maxFiles: 12,        // optional, default 12
  projectPath: "...",  // optional, for querying a second codebase
});
```

`codegraph_explore` is the single tool: it takes a natural-language question or a bag of symbol/file names and returns the verbatim line-numbered source of the relevant symbols grouped by file, the call path among them (dynamic-dispatch hops included), and a blast-radius summary of what depends on them. ONE call usually answers the whole question.

## When to prefer codegraph over native search

Use codegraph for **structural** questions — what calls what, what would break, where is X defined, what is X's signature. Use native grep/read only for **literal text** queries (string contents, comments, log messages) or after you already have a specific file open.

| Question | How |
|---|---|
| "How does X work?" / "Where is X defined?" / "What calls Y?" / "What would break if I changed Z?" | ONE `tools["cg"]["codegraph_explore"]` call naming the symbols (or a natural-language question) |
| "Show me Y's signature / source / docstring" | same — name Y in the query |
| "See several related symbols' source at once" | same — list them all in one query |
| "How does X reach Y? / the flow from X to Y" | same — name both endpoints; the call path is surfaced |
| "Is the index healthy?" | `codegraph status` (via @executor) |

## Rules of thumb

- **Answer directly — don't delegate exploration.** For "how does X work" / architecture / trace questions, answer with 1-2 `codegraph_explore` calls. Codegraph IS the pre-built index, so spawning a separate file-reading sub-task/agent — or running a grep + read loop — repeats work codegraph already did and costs more for the same answer.
- **Trust codegraph results.** They come from a full AST parse. Do NOT re-verify them with grep — that's slower, less accurate, and wastes context.
- **Don't grep or Read first** to find or understand indexed code — ONE `codegraph_explore` returns the relevant symbols' source together in a single round-trip.
- **Don't reconstruct a flow by hand** — name the endpoints in one `codegraph_explore` and it surfaces the path between them, dynamic-dispatch hops included.
- **After editing, check the staleness banner.** If a response starts with "Some files referenced below were edited since the last index sync…", Read those specific files for accurate content. A "CodeGraph auto-sync is DISABLED" banner means the watcher stopped entirely — Read files directly to confirm anything that may have changed.
- **Index lag**: the file watcher debounces ~500ms-1s behind writes; don't re-query immediately after editing a file in the same turn.

## If `.codegraph/` doesn't exist

The index is created with `codegraph init` in the project root when missing. If tools report "not initialized":

- Do not ask the user. Delegate to @executor: run `codegraph init` in the project root (indexing is default in v1.5; no flags needed), wait for it, then retry.
- If init fails with a stale-lock error, run `codegraph unlock` first, then `codegraph init` again.
- Verify with `codegraph status` (or `codegraph status -j` for JSON).
- If tools still report not initialized after indexing, the cg MCP server was started before the index existed — restart opencode once.

The file watcher keeps the index fresh after init; no manual reindexing day to day. After huge refactors, `codegraph sync` catches anything the watcher missed.
