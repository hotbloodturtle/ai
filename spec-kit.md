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

## 이 프로젝트에서의 위치

- **겹치는 것**: BMAD-METHOD(전체 SDLC, 더 무거움), superpowers `writing-plans`/`executing-plans`(플랜 파일 기반, 가벼움), Task Master(PRD → 태스크)
- **차별점**: GitHub 공식·에이전트 불문 표준 포맷, `constitution`으로 프로젝트 원칙 강제, `converge`로 기존 코드베이스 갭 분석
- **추천 용도**: 팀이 여러 에이전트를 섞어 쓰거나 스펙 산출물 자체가 필요한 프로젝트. 1인 소규모 작업이면 superpowers 플랜으로 충분

## 검증 기록

- 2026-08-19: v0.16.4 `uv tool install` 전역 설치, `specify init sk-demo --integration claude --script sh` 로 10개 스킬 + `.specify/` 생성 확인
