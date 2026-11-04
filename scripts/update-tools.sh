#!/usr/bin/env bash
# AI 도구 일괄 최신화 — verification.md "전체 최신화" 절차를 스크립트로. 멱등: 새 버전이 없으면 확인만 하고 끝난다.
# 실행: bash scripts/update-tools.sh   (app-auto /app-pull 이 이 파일을 찾아 매번 실행한다)
# 외부 설치 스크립트를 내려받아 실행하는 도구(codebase-memory)는 알리기만 한다.
set -uo pipefail
say() { printf '%s\n' "$*"; }
changed=0; restart=0
REPOS="$HOME/.claude/plugins/repos"
SKILLS="$HOME/.claude/skills"

say "## CLI (brew)"
want="rtk uv gh tmux node claude-squad"
inst=$(brew list --formula -1 2>/dev/null)
old=$(brew outdated --formula --quiet 2>/dev/null)
up=""
for f in $want; do grep -qx "$f" <<<"$inst" && grep -qx "$f" <<<"$old" && up="$up $f"; done
if [ -n "$up" ]; then
  brew upgrade $up >/dev/null 2>&1 && say "⬆️ brew:$up" || say "❌ brew upgrade 실패:$up"; changed=1
else say "✅ 최신"; fi

say "## CLI (npm -g)"
nold=$(npm outdated -g --parseable 2>/dev/null | cut -d: -f4 | sed 's/@[^@]*$//')
up=""
for p in @playwright/cli agent-device; do grep -qx "$p" <<<"$nold" && up="$up $p@latest"; done
if [ -n "$up" ]; then
  npm install -g $up >/dev/null 2>&1 && say "⬆️ npm:$up" || say "❌ npm 실패:$up"; changed=1
else say "✅ 최신"; fi
# 옛 버전 데몬이 남아 있으면 새 CLI 가 "daemon is busy" 로 실패한다 (2026-10-23, 11-04). 연결된 기기가 없을 때만 끈다.
if command -v agent-device >/dev/null && [ -f "$HOME/.agent-device/daemon.json" ]; then
  dv=$(python3 -c "import json;print(json.load(open('$HOME/.agent-device/daemon.json')).get('version',''))" 2>/dev/null)
  cv=$(agent-device --version 2>/dev/null)
  if [ -n "$dv" ] && [ "$dv" != "$cv" ]; then
    if [ -z "$(adb devices 2>/dev/null | tail -n +2 | grep -w device)" ]; then
      agent-device daemon stop --state-dir "$HOME/.agent-device" >/dev/null 2>&1 && say "🔧 agent-device 옛 데몬(${dv}) 종료"
    else say "⚠️ agent-device 옛 데몬(${dv})이 떠 있지만 기기가 연결돼 있어 두었다 — 작업 끝나고 다시 실행"; fi
  fi
fi

say "## clone 스킬"
pulled=""
for d in "$REPOS"/*/ "$HOME/.claude/design-systems/awesome-design-md/"; do
  [ -d "$d/.git" ] || continue
  n=$(basename "$d")
  if [ -n "$(git -C "$d" status --porcelain)" ]; then say "⚠️ $n: 커밋 안 된 변경이 있어 건너뜀"; continue; fi
  a=$(git -C "$d" rev-parse --short HEAD)
  git -C "$d" pull --ff-only -q >/dev/null 2>&1 || { say "❌ $n: pull 실패"; continue; }
  b=$(git -C "$d" rev-parse --short HEAD)
  [ "$a" != "$b" ] && { say "⬆️ $n ${a}→${b} $(git -C "$d" describe --tags --abbrev=0 2>/dev/null)"; pulled="$pulled $n"; changed=1; }
done
[ -z "$pulled" ] && say "✅ 최신"
# 새 스킬 flat 심링크 — 제외 정책: superpowers 의 diagnosing-superpowers, marketing 의 seo-audit(claude-seo 것 사용).
# document-skills 는 새 스킬을 자동 연결하지 않는다(정책: 골라서 연결) → 알리기만.
for pair in "superpowers:diagnosing-superpowers" "marketing-skills:seo-audit"; do
  r=${pair%%:*}; skip=${pair#*:}
  for s in "$REPOS/$r/skills"/*/; do
    [ -d "$s" ] || continue; n=$(basename "$s")
    [ "$n" = "$skip" ] || [ -e "$SKILLS/$n" ] && continue
    ln -s "${s%/}" "$SKILLS/$n" && say "🔗 새 스킬 연결: $n ($r)"; changed=1
  done
done
newdoc=$(for s in "$REPOS/document-skills/skills"/*/; do [ -d "$s" ] && [ ! -e "$SKILLS/$(basename "$s")" ] && basename "$s"; done | tr '\n' ' ')
[ -n "$newdoc" ] && say "ℹ️ document-skills 미연결(정책상 제외 또는 검토 필요): $newdoc"
for l in "$SKILLS"/*; do [ -L "$l" ] && [ ! -e "$l" ] && say "❌ 깨진 심링크: $l"; done

if grep -qw gstack <<<"$pulled" && [ -x "$REPOS/gstack/setup" ]; then
  say "## gstack setup"
  h=$(shasum "$HOME/.claude/settings.json" 2>/dev/null)
  (cd "$REPOS/gstack" && ./setup --host claude --no-prefix --no-team --no-plan-tune-hooks --no-timeline-stop-hook </dev/null >/dev/null 2>&1) \
    && say "⬆️ gstack $(cat "$REPOS/gstack/VERSION" 2>/dev/null)" || say "❌ gstack setup 실패"
  rm -rf "$SKILLS/codex"  # Codex 안 씀. setup 이 매번 다시 만든다
  [ "$h" = "$(shasum "$HOME/.claude/settings.json" 2>/dev/null)" ] && say "✅ settings.json 무변경" || say "⚠️ settings.json 이 바뀜 — 훅 등록 여부 확인 필요"
  "$REPOS/gstack/bin/gstack-config" set proactive false >/dev/null 2>&1
fi
if grep -qw claude-seo <<<"$pulled" && [ -f "$REPOS/claude-seo/install.sh" ]; then
  say "## claude-seo 인스톨러"
  py=$(brew --prefix python@3.11 2>/dev/null)/libexec/bin
  PATH="$py:$PATH" bash "$REPOS/claude-seo/install.sh" </dev/null >/dev/null 2>&1 && say "⬆️ claude-seo 재설치" || say "❌ claude-seo 인스톨러 실패 — 직접 실행 필요"
fi

say "## 플러그인"
claude plugin marketplace update >/dev/null 2>&1
any=0
for p in $(python3 -c "import json,os;d=json.load(open(os.path.expanduser('~/.claude/plugins/installed_plugins.json')));print(' '.join(d.get('plugins',d).keys()))" 2>/dev/null); do
  out=$(claude plugin update "$p" 2>&1 | tail -1)
  grep -q "updated from" <<<"$out" && { say "⬆️ $(sed -E 's/.*Plugin "([^"]+)" updated from ([^ ]+) to ([^ ]+).*/\1 \2→\3/' <<<"$out")"; any=1; restart=1; changed=1; }
done
[ $any = 0 ] && say "✅ 최신"

say "## skills CLI (hallmark·archify·grilling 등)"
out=$(npx -y skills update -g 2>&1 | sed 's/\x1b\[[0-9;]*[mK]//g')
u=$(grep -oE "Updated [^ ]+" <<<"$out" | cut -d' ' -f2 | tr '\n' ' ')
[ -n "$u" ] && { say "⬆️ $u"; changed=1; } || say "✅ 최신"
[ -e "$SKILLS/archify-review" ] && rm -rf "$SKILLS/archify-review" && say "🔧 archify-review 제거"

latest_tag() { git ls-remote --tags "$1" 2>/dev/null | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+$' | sort -V | tail -1; }
say "## Spec Kit"
if command -v specify >/dev/null; then
  cur=v$(specify --version 2>/dev/null | grep -oE '[0-9]+\.[0-9]+\.[0-9]+'); lt=$(latest_tag https://github.com/github/spec-kit.git)
  if [ -n "$lt" ] && [ "$cur" != "$lt" ]; then
    uv tool install specify-cli --from "git+https://github.com/github/spec-kit.git@$lt" --force >/dev/null 2>&1 \
      && { say "⬆️ Spec Kit ${cur}→${lt} (문서의 고정 태그도 갱신할 것)"; changed=1; } || say "❌ Spec Kit $lt 설치 실패"
  else say "✅ $cur"; fi
else say "— 미설치"; fi

say "## codebase-memory-mcp"
if command -v codebase-memory-mcp >/dev/null; then
  cur=v$(codebase-memory-mcp --version 2>/dev/null | grep -oE '[0-9]+\.[0-9]+\.[0-9]+'); lt=$(latest_tag https://github.com/DeusData/codebase-memory-mcp.git)
  [ -n "$lt" ] && [ "$cur" != "$lt" ] && say "⚠️ $cur → $lt 있음 — 외부 설치 스크립트라 작업자가 실행: codebase-memory.md 의 --skip-config 명령" || say "✅ $cur"
else say "— 미설치"; fi

say ""
[ $changed = 1 ] && say "결과: 갱신함 — ai 레포 verification.md 에 기록할 것" || say "결과: 바뀐 것 없음"
[ $restart = 1 ] && say "⚠️ 플러그인이 갱신됐다 — Claude Code 재시작 후 반영"
exit 0
