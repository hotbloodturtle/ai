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

- GitHub: https://github.com/bmadcode/BMAD-METHOD

## 설치

### 전역 설치 (모든 세션에서 사용)

gstack과 동일한 패턴으로, git clone 후 `~/.claude/skills/`에 **flat 심링크**를 생성한다.
스킬은 `src/core-skills/`와 `src/bmm-skills/<단계>/` 아래에 있다 (레포 루트 직하가 아니라 `src/` 하위임에 주의).

> ⚠️ Claude Code 스킬 탐색은 `~/.claude/skills/<스킬>/SKILL.md` **한 단계만** 스캔한다. 따라서 `~/.claude/skills/bmad-method/<스킬>/` 처럼 2단계로 중첩하면 인식되지 않는다. 반드시 **최상위로 flat 심링크**해야 한다 (`bmad-` 접두어라 충돌 없음).

```bash
# 1. 레포 클론
git clone --depth 1 https://github.com/bmadcode/BMAD-METHOD.git ~/.claude/plugins/repos/bmad-method
mkdir -p ~/.claude/skills

# 2. 코어 + 라이프사이클 스킬 일괄 flat 심링크
BMAD=~/.claude/plugins/repos/bmad-method/src
for skill in \
  "$BMAD"/core-skills/bmad-*/ \
  "$BMAD"/bmm-skills/1-analysis/bmad-*/ \
  "$BMAD"/bmm-skills/1-analysis/research/bmad-*/ \
  "$BMAD"/bmm-skills/2-plan-workflows/bmad-*/ \
  "$BMAD"/bmm-skills/3-solutioning/bmad-*/ \
  "$BMAD"/bmm-skills/4-implementation/bmad-*/ ; do
    [ -d "$skill" ] || continue
    ln -sfn "$skill" ~/.claude/skills/$(basename "$skill")
done
```

설치 후 어떤 프로젝트에서든 `/bmad-help`, `/bmad-prd` 등으로 호출 가능.

검증된 결과 (2026-05): 위 패턴으로 총 **44개 스킬** 자동 등록됨 (코어 12개 + 라이프사이클 32개).
`web-bundles/` 아래에 코치 스킬 6개(prd-coach, ux-coach, brainstorming-coach 등)가 더 있으나 `bmad-` 접두어가 아니라 위 루프에는 포함되지 않는다 (필요 시 별도 심링크).

업데이트: `cd ~/.claude/plugins/repos/bmad-method && git pull`

### 프로젝트 설치 (특정 프로젝트에만)

```bash
npx bmad-method install
npx bmad-method install --directory /path/to/project --modules bmm --tools claude-code --yes
```

## 참고 사항

- Node.js v20+, Python 3.10+, uv 패키지 매니저 필요 (프로젝트 설치 시)
- 전역 설치는 git만 있으면 가능 (심링크 방식)
- MIT 라이선스 (무료, 오픈소스)
- Superpowers가 개발 워크플로 중심이라면, BMAD는 PM/아키텍트/UX까지 포함한 상위 프레임워크
