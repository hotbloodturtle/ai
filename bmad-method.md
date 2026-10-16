# BMAD-METHOD

> 12+ 전문 에이전트와 34+ 워크플로로 전체 SDLC를 커버하는 AI 기반 애자일 개발 프레임워크

## 소개

BMAD-METHOD(Breakthrough Method for Agile AI Driven Development)는 AI 에이전트를 단순 도구가 아닌 전문 협력자(Expert Collaborator)로 활용하는 애자일(Agile) 개발 프레임워크다.
PM, 아키텍트, 개발자, UX 디자이너 등 12개 이상의 전문 역할 에이전트가 구조화된 워크플로를 통해 브레인스토밍부터 배포까지 전 과정을 지원한다.
프로젝트 복잡도에 따라 자동으로 플래닝 깊이를 조절하는 Scale-Domain-Adaptive 방식으로 동작한다.

## 주요 기능

### 모듈

| 모듈 | 약자 | 역할 |
|------|------|------|
| BMad Method | BMM | 코어 프레임워크, 34+ 워크플로 |
| BMad Builder | BMB | 커스텀 에이전트/워크플로 생성 |
| Test Architect | TEA | 리스크 기반 테스트 전략 자동화 |
| Game Dev Studio | BMGD | Unity, Unreal, Godot 게임 개발 |
| Creative Intelligence Suite | CIS | 혁신, 브레인스토밍(Brainstorming), 디자인 씽킹(Design Thinking) |

### 핵심 특징

- **12+ 전문 에이전트**: PM, Architect, Developer, UX Designer 등 역할별 도메인 전문가
- **Party Mode**: 여러 에이전트 페르소나가 단일 세션에서 협업
- **Scale-Domain-Adaptive**: 버그 수정부터 엔터프라이즈 시스템까지 복잡도에 맞게 자동 조절
- **bmad-help 스킬**: 실시간 가이드 제공
- **Claude Code 플러그인**: `.claude-plugin/` 디렉토리로 네이티브(Native) 통합

## 공식 링크

- GitHub: https://github.com/bmad-code-org/BMAD-METHOD (구 bmadcode/BMAD-METHOD, 리다이렉트됨)
- Docs: https://docs.bmad-method.org/

## 설치 (v6.11 기준)

v6부터 스킬이 `{project-root}/_bmad/`(config.yaml, `scripts/*.py`, `_config/bmad-help.csv`)를 참조하므로 **프로젝트별 설치가 전제**다.
Spec Kit·agent-device와 같은 패턴: 전역에는 얇은 래퍼 스킬만 두고, 실제 스킬은 프로젝트에 `npx bmad-method install`로 생성한다.

> ⚠️ 이전 방식(레포 클론 + `~/.claude/skills`에 flat 심링크, 2026-05 검증 44개)은 **폐기**.
> `_bmad/`가 없으면 `bmad-help` 카탈로그·customize 스크립트가 동작하지 않고, 레포 구조도 `1-analysis/2-plan/...` → `agents/plan/ship/v6-shims`로 바뀌어 기존 심링크 루프가 깨진다. 이 기기에서도 심링크가 `~/.claude/skills/bmad-method/bmad-*` 로 2단계 중첩돼 있어 실제로는 인식되지 않던 상태였음 (2026-08-19 발견, 래퍼로 교체).

### 프로젝트 설치

```bash
# Node 20.12+, uv 필요
npx -y bmad-method@6.11.0 install --directory . --modules bmm --tools claude-code --yes
```

생성물: `.claude/skills/bmad-*/` **49개**(코어 8 + bmm 22 + deprecated shim 19), `_bmad/{_config,bmm,core,custom,scripts}/`, `_bmad-output/`.
`--yes`는 shim까지 설치한다. 대화형(`npx bmad-method install`)으로 돌리면 shim 제외 선택 가능.
설치 후 `_bmad/bmm/config.yaml`의 `user_name`, `communication_language`(ko) 조정 → 새 세션에서 `/bmad-help`.

업데이트: 같은 명령 재실행 (Quick Update). 프리릴리스: `npx bmad-method@next install`.

## 전역 래퍼 스킬 등록 (새 기기 세팅)

새 폴더 새 세션에서 Claude가 BMAD를 알게 하려면 부트스트랩 래퍼를 전역에 둔다.

```bash
# 1. 부록 A → ~/.claude/skills/bmad-method/SKILL.md 저장
mkdir -p ~/.claude/skills/bmad-method
# 2. 새 세션에서 "bmad로 시작해줘" 로 확인 → 자동으로 npx bmad-method install 실행
```

암묵 트리거("PRD 만들어줘")는 불안정하므로 **"bmad"를 이름으로 부르는 것**을 권장.

### 자동 승인 (선택)
`~/.claude/settings.json` permissions.allow에 `"Bash(npx bmad-method *)"`, `"Bash(npx -y bmad-method*)"` 추가.

## 참고 사항

- Node.js v20+, Python 3.10+, uv 패키지 매니저 필요 (프로젝트 설치 시)
- MIT 라이선스 (무료, 오픈소스)
- Superpowers가 개발 워크플로 중심이라면, BMAD는 PM/아키텍트/UX까지 포함한 상위 프레임워크

## 검증 기록

- 2026-08-19: v6.11.0 `npx -y bmad-method@6.11.0 install --directory . --modules bmm --tools claude-code --yes` → 49 스킬 + `_bmad/` 생성 확인. 깨진 전역 심링크 제거, 래퍼 스킬 등록 (부록 A). 레포 클론(`~/.claude/plugins/repos/bmad-method`)은 참고용으로만 남김(remote는 bmad-code-org로 변경).
- 2026-05: 구버전 flat 심링크 44개 (폐기)

## 부록 A: SKILL.md 템플릿

`~/.claude/skills/bmad-method/SKILL.md`

````markdown
---
name: bmad-method
description: BMAD-METHOD(AI 애자일 SDLC 프레임워크)를 프로젝트에 부트스트랩한다. _bmad/가 없으면 npx bmad-method install로 스캐폴딩한 뒤 /bmad-help로 안내한다. Use when "bmad", "비마드", "BMAD 메소드", "PRD 만들어", "아키텍처 문서", "에픽/스토리", "스프린트 플래닝", "party mode"
---

# bmad-method

PM·아키텍트·개발자·UX 등 역할 에이전트 + 34+ 워크플로. v6부터 스킬이 `{project-root}/_bmad/`(config, scripts, help 카탈로그)에 의존하므로 **프로젝트별 설치**가 전제다. 이 래퍼는 부트스트랩만 담당한다.

## 사전 확인

```bash
node -v   # 20.12+ 필요. uv도 필요 (스킬이 uv run _bmad/scripts/*.py 호출)
```

## 부트스트랩

```bash
ls _bmad 2>/dev/null || npx -y bmad-method@6.11.0 install --directory . --modules bmm --tools claude-code --yes
```

생성물: `.claude/skills/bmad-*/` (49개, deprecated shim 포함), `_bmad/{_config,bmm,core,custom,scripts}/`, `_bmad-output/`.
init 직후에는 새 스킬이 현재 세션에 로드되지 않을 수 있다 → 사용자에게 **세션 재시작** 안내.
`_bmad/bmm/config.yaml`의 `user_name`, `communication_language`(예: ko)를 사용자에게 확인/조정 권유.

## 이후 순서 (사용자에게 안내)

- 어디서 시작할지 모르면 `/bmad-help`
- 아이디어 검증 `/bmad-forge-idea` → `/bmad-product-brief` / `/bmad-prfaq`
- 계획 `/bmad-prd` → `/bmad-ux` → `/bmad-architecture` → `/bmad-create-epics-and-stories` → `/bmad-sprint-planning`
- 구현 `/bmad-build`(또는 `/bmad-build-auto`) → `/bmad-code-review` → `/bmad-retrospective`
- 기존 코드베이스: `/bmad-project-context`(또는 `/bmad-generate-project-context`)
- 다관점 토론 `/bmad-party-mode`, 심층 질문 `/bmad-advanced-elicitation`

## 규칙

- `bmad-create-prd`, `bmad-dev-story` 등 `v6-shims`는 deprecated → 통합 스킬(`bmad-prd`, `bmad-build`)을 직접 쓴다.
- 산출물은 `_bmad-output/` 아래. `_bmad/`는 설치 산출물이므로 직접 수정하지 않고 `_bmad/custom/*.toml`로 오버라이드.
- 업데이트: 같은 install 명령 재실행 (Quick Update).
````
