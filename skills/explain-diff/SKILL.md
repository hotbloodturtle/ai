---
name: explain-diff
description: Explain a diff, commit range, branch, or pull request as a self-contained interactive HTML walkthrough when the user requests an explain-diff report.
---

# Explain a change

Identify the requested comparison and read the changed code plus enough surrounding context to explain it correctly. For a PR, use its actual diff and description. State any ambiguity about the base or unavailable source.

Create one self-contained HTML file with inline CSS/JS in the OS temporary directory, named `YYYY-MM-DD-explain-diff.html`. Include:

- Background: the relevant existing behavior and why the change is needed.
- Intuition: a small concrete example; use HTML/SVG diagrams when useful.
- Code: an explanation organized by behavior rather than diff order, with file references.
- Quiz: five multiple-choice questions with click feedback, similarly sized choices and varied correct-answer positions.

Escape source snippets as text. Distinguish observed behavior from assumptions. Return the file link; open it locally when the user's workflow calls for that.

Adapted from Geoffrey Litt's concept: https://gist.github.com/geoffreylitt/a29df1b5f9865506e8952488eac3d524
