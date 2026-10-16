---
name: bmad-method
description: Bootstrap the stable BMAD Method project workflow when the user explicitly asks to use BMAD for product planning, architecture, or implementation.
---

# BMAD Method

The verified stable baseline is `bmad-method@6.11.0`. Install in the intended project, not in a reference/documentation repository unless that is the requested target.

First inspect `_bmad/`, existing BMAD skills, and installed plugins. Reuse a working installation rather than adding a second version. When BMAD is absent:

- Claude Code: use the same command with `--tools claude-code`.

Use `--communication-language Korean --document-output-language Korean` when Korean output fits the user's request; otherwise preserve their language preference.
This baseline generates 49 skills, `_bmad/` configuration, and `_bmad-output/`. The Claude target is `.claude/skills/`.
Start with the generated bmad-help skill, then choose the workflow matching the request. New skills may require a new session.

For an existing installation, inspect the installed version's update options rather than overwriting configuration. Do not silently switch to prerelease.

Source: https://github.com/bmad-code-org/BMAD-METHOD
