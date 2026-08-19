# Spec Kit

> GitHub 공식 스펙 주도 개발(Spec-Driven Development, SDD) 툴킷 — 스펙 → 플랜 → 태스크 → 구현을 슬래시 커맨드로 강제

## 소개

Spec Kit은 "코드보다 스펙을 먼저" 쓰게 만드는 GitHub 공식 워크플로 툴킷이다.
`specify` CLI가 프로젝트에 템플릿·스크립트·에이전트 스킬을 심어주고, 이후 에이전트 안에서 `/speckit-*` 커맨드로 헌법(constitution) → 스펙 → 플랜 → 태스크 → 구현 순서를 밟는다.
30+ 에이전트(Claude Code, Copilot, Codex, Gemini 등)를 지원하며 Claude Code는 `.claude/skills/speckit-*/SKILL.md`로 설치된다.

## 주요 기능

| 커맨드 | 역할 |
|--------|------|
| `/speckit-constitution` | 프로젝트 원칙(불변 규칙) 정의 → `.specify/memory/constitution.md` |
| `/speckit-specify` | 자연어 요구사항 → `specs/NNN-feature/spec.md` + 피처 브랜치 생성 |
| `/speckit-clarify` (선택) | 스펙의 모호한 부분을 구조화된 질문으로 해소 |
| `/speckit-plan` | 기술 스택·아키텍처 플랜 (`plan.md`) |
| `/speckit-checklist` (선택) | 요구사항 완전성/일관성 체크리스트 |
| `/speckit-tasks` | 실행 가능한 태스크 목록 (`tasks.md`) |
| `/speckit-analyze` (선택) | spec/plan/tasks 간 정합성 리포트 |
| `/speckit-implement` | 태스크 순차 실행 |
| `/speckit-converge` | 코드베이스를 스펙과 대조해 남은 작업을 tasks.md에 추가 (brownfield용) |
| `/speckit-taskstoissues` | 태스크 → GitHub Issues |

- 확장(extensions)/프리셋(presets)/번들(bundles)로 훅·템플릿 커스터마이즈 가능
- 템플릿이 CLI 패키지에 번들 → `init` 시 네트워크 불필요

## 공식 링크

- GitHub: https://github.com/github/spec-kit
- 방법론 설명: https://github.com/github/spec-kit/blob/main/spec-driven.md

## 설치

전역은 CLI만, 스킬은 **프로젝트별**로 들어간다 (전역 `~/.claude/skills`가 아님).

```bash
# 1. CLI (Python 3.11+, uv 필요) — 검증 v0.16.4
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git@v0.16.4
specify --version

# 2. 프로젝트에 적용
specify init . --integration claude --script sh     # 기존 프로젝트: --here / 새 프로젝트: specify init <name> --integration claude
```

생성물: `.claude/skills/speckit-*/` (10개), `.specify/{memory,scripts,templates,workflows}/`.
이후 Claude Code에서 `/speckit-constitution` → `/speckit-specify "..."` 순으로 진행.

주의:
- 커맨드명은 문서의 `/speckit.xxx`가 아니라 실제로는 `/speckit-xxx` (스킬 디렉토리명 기준)
- `--no-git` 옵션은 없음. git 없으면 `--ignore-agent-tools`와 별개로 그냥 진행됨
- `specify integration list`는 `.specify/`가 있는 디렉토리 안에서만 동작

## 전역 래퍼 스킬 등록 (새 기기 세팅)

`/speckit-*`는 프로젝트별이라 새 폴더 새 세션에서 Claude가 Spec Kit의 존재를 모른다.
agent-device와 같은 패턴으로 얇은 전역 래퍼를 두면 "spec kit"이라고 부를 때 알아서 `specify init`부터 진행한다.

```bash
# 1. CLI
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git@v0.16.4
# 2. 부록 A → ~/.claude/skills/spec-kit/SKILL.md 저장
mkdir -p ~/.claude/skills/spec-kit
# 3. 새 세션에서 "spec kit으로 시작해줘" 로 확인
```

암묵 트리거("스펙부터 짜줘")는 불안정하므로 **"spec kit"을 이름으로 부르는 것**을 권장 (hallmark와 동일).

### 자동 승인 (선택)
`~/.claude/settings.json` permissions.allow에 `"Bash(specify *)"` 추가.

## 이 프로젝트에서의 위치

- **겹치는 것**: BMAD-METHOD(전체 SDLC, 더 무거움), superpowers `writing-plans`/`executing-plans`(플랜 파일 기반, 가벼움), Task Master(PRD → 태스크)
- **차별점**: GitHub 공식·에이전트 불문 표준 포맷, `constitution`으로 프로젝트 원칙 강제, `converge`로 기존 코드베이스 갭 분석
- **추천 용도**: 팀이 여러 에이전트를 섞어 쓰거나 스펙 산출물 자체가 필요한 프로젝트. 1인 소규모 작업이면 superpowers 플랜으로 충분

## 검증 기록

- 2026-08-19: 전역 래퍼 `~/.claude/skills/spec-kit/SKILL.md` 등록 (부록 A)
- 2026-08-19: v0.16.4 `uv tool install` 전역 설치, `specify init sk-demo --integration claude --script sh` 로 10개 스킬 + `.specify/` 생성 확인

## 부록 A: SKILL.md 템플릿

`~/.claude/skills/spec-kit/SKILL.md`

````markdown
---
name: spec-kit
description: GitHub Spec Kit으로 스펙 주도 개발(SDD) 워크플로를 시작한다. 프로젝트에 .specify/가 없으면 specify init으로 스캐폴딩한 뒤 /speckit-* 커맨드로 안내한다. Use when "spec kit", "speckit", "스펙킷", "스펙 주도", "SDD", "스펙부터 작성", "constitution", "specify init"
---

# spec-kit

GitHub 공식 스펙 주도 개발 툴킷. 스킬(`/speckit-*`)은 프로젝트별로 생성되므로, 이 래퍼는 **부트스트랩만** 담당한다.

## 사전 확인

```bash
command -v specify || uv tool install specify-cli --from git+https://github.com/github/spec-kit.git@v0.16.4   # Python 3.11+, uv 필요
```

## 부트스트랩

```bash
ls .specify 2>/dev/null || specify init . --integration claude --script sh   # 비어있지 않은 디렉토리면 --force
```

생성물: `.claude/skills/speckit-*/` (10개), `.specify/{memory,scripts,templates,workflows}/`.
init 직후에는 새 스킬이 현재 세션에 로드되지 않을 수 있다 → 사용자에게 **세션 재시작(또는 새 세션)** 을 안내한다.

## 이후 순서 (사용자에게 안내)

1. `/speckit-constitution` — 프로젝트 원칙
2. `/speckit-specify <요구사항>` — 스펙 + 피처 브랜치
3. `/speckit-clarify` (선택) → `/speckit-plan` → `/speckit-checklist` (선택)
4. `/speckit-tasks` → `/speckit-analyze` (선택) → `/speckit-implement`
5. 기존 코드베이스: `/speckit-converge` 로 스펙 대비 갭을 tasks.md에 추가

## 규칙

- 커맨드명은 `/speckit-xxx` (점 아님, 하이픈).
- 스펙 산출물은 `specs/NNN-feature/` 아래. 임의 위치에 spec.md 만들지 않는다.
- `.specify/scripts/bash/*.sh`는 스킬이 호출하므로 임의 수정 금지.
````
