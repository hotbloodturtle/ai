---
name: playwright-cli
description: Use the Playwright CLI for browser interaction, screenshots, and web UI verification when a terminal browser workflow is appropriate.
---

# Browser CLI

Check `playwright-cli --version` and `playwright-cli --help`. If missing, install the Microsoft package `npm install -g @playwright/cli`.
Use a named session such as `playwright-cli -s=qa open <url>`, then snapshot → interact with fresh refs → snapshot/screenshot to verify.
Run in the intended project or a temporary directory so browser artifacts do not pollute unrelated repositories.
Use `playwright-cli --help <command>` for installed-version options. Close only the session created for the task, not all user sessions.
Browser actions that send, purchase, publish, or delete still require authorization for the actual action.

Source: https://github.com/microsoft/playwright-cli
