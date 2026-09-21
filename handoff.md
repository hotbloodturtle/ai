# 핸드오프: claude-mem 제거 (2026-09-21)

claude-mem은 이 환경에서 **완전히 제거**했다. 백그라운드 observer가 도구를 쓸 때마다 Claude를 따로 호출해서(하루 600~800건) 구독 한도를 소진시켰기 때문이다. 세션 간 메모리/코드 탐색은 codebase-memory-mcp·serena로 대체한다. 새로 설치하지 않는다.

## 다른 기기에서 제거 절차 (macOS)

```bash
claude plugin uninstall claude-mem@thedotmack
claude plugin marketplace remove thedotmack
pkill -f claude-mem                      # worker·mcp-server·chroma-mcp
rm -rf ~/.claude-mem \
  ~/.claude/plugins/cache/thedotmack \
  ~/.claude/plugins/marketplaces/thedotmack ~/.claude/plugins/marketplaces/thedotmack-claude-mem
# Codex에 설치했었다면
rm -rf ~/.codex/plugins/cache/thedotmack/claude-mem ~/.codex/plugins/cache/claude-mem-local
```

## 확인

```bash
pgrep -fl claude-mem                      # 출력 없어야 함
grep -rn "claude-mem\|thedotmack" ~/.claude/settings.json ~/.claude/plugins/*.json ~/.claude.json ~/.codex/config.toml  # 출력 없어야 함
```
