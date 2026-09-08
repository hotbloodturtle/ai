#!/usr/bin/env python3
"""Read-only installation inventory; never prints MCP args, URLs, or credentials."""
import json
import os
from pathlib import Path
import platform
import shutil
import sys
import tomllib


def main():
    home = Path.home()
    codex = Path(os.environ.get("CODEX_HOME", home / ".codex"))
    config = codex / "config.toml"
    data = tomllib.loads(config.read_text()) if config.exists() else {}
    roots = [home / ".agents/skills", codex / "skills"]
    skills = {}
    broken = []
    for root in roots:
        for entry in sorted(root.iterdir()) if root.exists() else []:
            if entry.name.startswith("."):
                continue
            if entry.is_symlink() and not entry.exists():
                broken.append(str(entry))
            elif (entry / "SKILL.md").is_file():
                skills.setdefault(entry.name, []).append(str(entry))
    report = {
        "platform": platform.system(),
        "architecture": platform.machine(),
        "python": platform.python_version(),
        "cli": {name: bool(shutil.which(name)) for name in [
            "claude", "codex", "node", "bun", "uv", "gh", "tmux", "rtk",
            "playwright-cli", "agent-device", "specify", "codebase-memory-mcp",
            "claude-squad", "cs", "soffice", "pandoc", "pdftoppm",
        ]},
        "mcp": {name: {"enabled": value.get("enabled", True)}
                for name, value in data.get("mcp_servers", {}).items()},
        "local_plugin_config": {name: {"enabled": value.get("enabled", True)}
                                for name, value in data.get("plugins", {}).items()},
        "standalone_skills": sorted(skills),
        "duplicate_directory_names": {name: paths for name, paths in skills.items() if len(paths) > 1},
        "broken_symlinks": broken,
        "global_rules": (codex / "AGENTS.md").is_file(),
        "standalone_hooks_file": (codex / "hooks.json").is_file(),
        "document_runtime": {
            "python": any((home / ".local/share/ai-tools/document-runtime/.venv" / path).exists()
                          for path in ["bin/python", "Scripts/python.exe"]),
            "node_modules": (home / ".local/share/ai-tools/document-runtime/node_modules").is_dir(),
        },
        "limits": "Registration/files only. Remote plugins, declared skill-name collisions, hook trust, authentication and runtime health require separate verification.",
    }
    print(json.dumps(report, ensure_ascii=False, indent=2))
    return 1 if broken else 0


if __name__ == "__main__":
    sys.exit(main())
