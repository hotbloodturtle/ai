---
name: spec-kit
description: Bootstrap GitHub Spec Kit when the user asks for Spec Kit, speckit, or spec-driven development using that toolkit.
---

# Spec Kit

Check `specify --version` and `specify init --help`. The verified baseline is 0.16.4.
If missing, install with `uv tool install specify-cli --from git+https://github.com/github/spec-kit.git@v0.16.4`.

Initialize the user's intended project, not this reference repository:

- Codex: `specify init . --integration codex --integration-options="--skills" --script sh`
- Claude Code: `specify init . --integration claude --script sh`
- On native Windows choose `--script ps`.

Inspect an existing `.specify/` and integration before initializing. Do not use `--force` to overwrite existing work without reviewing the affected files. If `.specify/` exists for another agent, inspect `specify integration --help` to add the missing integration.

Codex skills are generated in `.agents/skills/speckit-*/`; Claude skills in `.claude/skills/speckit-*/`.
Guide the user through constitution → specify → clarify → plan → tasks → analyze → implement, choosing steps appropriate to the request. Codex invocation is `$speckit-constitution`; Claude uses `/speckit-constitution` in this version. If skills are not visible, start a new session.

Source: https://github.com/github/spec-kit
