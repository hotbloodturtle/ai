#!/usr/bin/env python3
"""Read-only installation inventory; never prints MCP args, URLs, or credentials."""
import json
from pathlib import Path
import platform
import shutil
import sys


def load(path):
    try:
        return json.loads(path.read_text())
    except (OSError, ValueError):
        return {}


def main():
    home = Path.home()
    claude = home / ".claude"
    settings = load(claude / "settings.json")
    plugins = load(claude / "plugins/installed_plugins.json").get("plugins", {})
    root = claude / "skills"
    skills = []
    broken = []
    for entry in sorted(root.iterdir()) if root.exists() else []:
        if entry.name.startswith("."):
            continue
        if entry.is_symlink() and not entry.exists():
            broken.append(str(entry))
        elif (entry / "SKILL.md").is_file():
            skills.append(entry.name)
    report = {
        "platform": platform.system(),
        "architecture": platform.machine(),
        "python": platform.python_version(),
        "cli": {name: bool(shutil.which(name)) for name in [
            "claude", "node", "bun", "uv", "gh", "tmux", "rtk",
            "playwright-cli", "agent-device", "specify", "codebase-memory-mcp",
            "claude-squad", "cs", "soffice", "pandoc", "pdftoppm",
        ]},
        "mcp": sorted(load(home / ".claude.json").get("mcpServers", {})),
        "plugins": sorted(plugins),
        "standalone_skills": skills,
        "broken_symlinks": broken,
        "global_rules": (claude / "CLAUDE.md").is_file(),
        "hook_events": sorted(settings.get("hooks", {})),
        "status_line": "statusLine" in settings,
        "document_runtime": {
            "python": any((home / ".local/share/ai-tools/document-runtime/.venv" / path).exists()
                          for path in ["bin/python", "Scripts/python.exe"]),
            "node_modules": (home / ".local/share/ai-tools/document-runtime/node_modules").is_dir(),
        },
        "limits": "Registration and top-level files only. Project-scoped MCP, nested skills, hook behavior, authentication and runtime health require Claude Code runtime verification.",
    }
    print(json.dumps(report, ensure_ascii=False, indent=2))
    return 1 if broken else 0


if __name__ == "__main__":
    sys.exit(main())
