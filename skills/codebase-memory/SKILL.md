---
name: codebase-memory
description: Use Codebase Memory MCP for repository architecture, symbol dependencies, caller tracing, and change-impact analysis when a structural code graph is useful.
---

# Codebase Memory

Use the connected codebase-memory MCP server's actual tool schemas; tool names and parameters can vary by version.
Start with `list_projects` and select the intended repository. If it is not indexed, index that repository before drawing conclusions. Check indexing status when results appear incomplete or stale.

- Find symbols with `search_graph`, then read source with `get_code_snippet`.
- For callers and callees, use `trace_path` with the correct direction and discovered symbol name.
- Read `get_graph_schema` before writing a `query_graph` query.
- Use `detect_changes` for graph-backed impact analysis of local changes.
- Follow pagination; absence in a truncated or stale graph is not proof that code is unused.

Graph analysis complements source inspection. For simple text lookup, ordinary file search may be sufficient. Do not delete stored projects or modify persistent ADRs merely to answer a read-only question.
The standalone skill does not install automatic lifecycle/gate hooks.

Source: https://github.com/DeusData/codebase-memory-mcp
