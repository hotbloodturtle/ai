# planning-with-files

> Manus 스타일의 파일 기반 영속적 플래닝(Persistent Planning) 스킬

## 소개

planning-with-files는 에이전트가 계획을 파일(plan.md)로 작성하고 관리하는 스킬이다.
세션이 종료되어도 계획이 파일로 남아 컨텍스트(Context)를 유지하며, 체계적으로 작업을 진행할 수 있다.
플랫폼에 독립적인 구조로, 파일 시스템 접근이 가능한 모든 환경에서 동작한다.

## 주요 기능

- 파일 기반 계획 관리 (plan.md)
- 세션 간 계획 영속성(Persistence)
- 체크리스트(Checklist) 기반 진행 추적
- 인수인계(Handoff) 지원

## 공식 링크

- GitHub: https://github.com/OthmanAdi/planning-with-files

## 설치 (Claude Code 기준)

저장소에 6개 언어 변형(English/Spanish/Chinese/German/Traditional Chinese/Arabic)이 있으니 필요한 변형만 심링크.

### 영어판 단일 설치 (권장)
```bash
mkdir -p ~/.claude/plugins/repos ~/.claude/skills
git clone --depth 1 https://github.com/OthmanAdi/planning-with-files.git ~/.claude/plugins/repos/planning-with-files

ln -sfn ~/.claude/plugins/repos/planning-with-files/skills/planning-with-files \
  ~/.claude/skills/planning-with-files
```

### 다국어 변형 (전체)
```bash
for skill in ~/.claude/plugins/repos/planning-with-files/skills/planning-with-files*/; do
  ln -sfn "$skill" ~/.claude/skills/$(basename "$skill")
done
```

### 검증된 함정
- 레포 **전체**를 `~/.claude/skills/planning-with-files/`에 그대로 클론하면 **최상위에 SKILL.md가 없어** Claude Code의 1단계 스캔으로는 인식되지 않는다(비활성 클론). 반드시 레포는 `~/.claude/plugins/repos/`에 두고 `skills/` 하위만 최상위로 flat 심링크할 것.
- 플러그인 마켓플레이스로 설치한 경우 `planning-with-files:*` 네임스페이스(`planning-with-files:plan`, `planning-with-files:status` 등)로 등록된다 — 이 경우 심링크는 불필요하며, 비활성 클론이 남아 있으면 제거해도 된다.

### 업데이트
```bash
cd ~/.claude/plugins/repos/planning-with-files && git pull
```

---

## Codex

[공식 Codex 안내](https://github.com/OthmanAdi/planning-with-files/blob/master/docs/codex.md)의 personal installation을 따른다.

```bash
mkdir -p "$HOME/.local/share/ai-tools" "$HOME/.agents/skills" "$HOME/.codex/hooks"
git clone --depth 1 https://github.com/OthmanAdi/planning-with-files.git "$HOME/.local/share/ai-tools/planning-with-files"
# 기존 대상이 없을 때:
cp -R "$HOME/.local/share/ai-tools/planning-with-files/.agents/skills/planning-with-files" "$HOME/.agents/skills/"
```

원본 `.codex/hooks/` 파일을 `~/.codex/hooks/`에 복사하고 원본 `.codex/hooks.json`의 이벤트를 기존 `~/.codex/hooks.json`에 **병합**한다. 기존 파일을 통째로 덮어쓰지 않는다. 같은 entry를 중복 추가하지 않는다. 2026-09 원본은 SessionStart, UserPromptSubmit, PreToolUse, PermissionRequest, PostToolUse, PreCompact, Stop의 7개 이벤트를 제공한다.

플러그인 설치와 standalone 훅 설치는 대안이다. 둘 다 활성화하면 중복 실행된다. 이번 구성은 standalone이다. `/hooks`에서 신뢰 확인한 다음 사용한다. 단발 작업에서 계획 주입을 끄려면 해당 실행에 `PLANNING_DISABLED=1`을 지정한다. 자동 훅은 프로젝트 파일을 사용하며, 과거 세션 로그 catchup은 별도 명시적 모드다.
