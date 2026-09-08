---
name: agent-device
description: Use agent-device to inspect and test mobile apps on Android or Apple simulators and devices, including React Native app QA.
---

# Device QA

Check `agent-device --version` and `agent-device doctor`. If missing, install `npm install -g agent-device`; Node 22.12+ is needed for the documented baseline.
Android requires its SDK/adb; Apple simulators require Xcode on macOS.

Use `agent-device devices` to identify the intended target. Choose it explicitly when several devices are available.
Follow inspect → act → verify: open the app, `snapshot -i`, interact with current accessibility refs, inspect the result, and capture a screenshot where useful.
Use `--settle` on supported interaction commands, not on `open`, `snapshot`, or `close`. Reacquire refs after the screen changes.
Read `agent-device help manual-qa`, `agent-device help validate`, or `agent-device help react-native` when those workflows apply.
Operate within the requested app/task; obtain authorization before actual purchases, sending messages, or deleting user data.

Source: https://github.com/callstack/agent-device
