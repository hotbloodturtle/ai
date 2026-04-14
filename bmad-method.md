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

gstack과 동일한 패턴으로, git clone 후 `~/.claude/skills/`에 심링크를 생성한다.

```bash
# 1. 레포 클론
git clone --depth 1 https://github.com/bmadcode/BMAD-METHOD.git ~/.claude/plugins/repos/bmad-method

# 2. 스킬 디렉토리 생성
mkdir -p ~/.claude/skills/bmad-method

# 3. 코어 스킬 심링크 (11개)
for skill in ~/.claude/plugins/repos/bmad-method/src/core-skills/bmad-*/; do
    ln -sf "$skill" ~/.claude/skills/bmad-method/$(basename "$skill")
done

# 4. 라이프사이클 스킬 심링크 (30개) - 단계별로 실행
# 1-analysis
for skill in ~/.claude/plugins/repos/bmad-method/src/bmm-skills/1-analysis/bmad-*/; do
    ln -sf "$skill" ~/.claude/skills/bmad-method/$(basename "$skill")
done
for skill in ~/.claude/plugins/repos/bmad-method/src/bmm-skills/1-analysis/research/bmad-*/; do
    ln -sf "$skill" ~/.claude/skills/bmad-method/$(basename "$skill")
done

# 2-plan-workflows
for skill in ~/.claude/plugins/repos/bmad-method/src/bmm-skills/2-plan-workflows/bmad-*/; do
    ln -sf "$skill" ~/.claude/skills/bmad-method/$(basename "$skill")
done

# 3-solutioning
for skill in ~/.claude/plugins/repos/bmad-method/src/bmm-skills/3-solutioning/bmad-*/; do
    ln -sf "$skill" ~/.claude/skills/bmad-method/$(basename "$skill")
done

# 4-implementation
for skill in ~/.claude/plugins/repos/bmad-method/src/bmm-skills/4-implementation/bmad-*/; do
    ln -sf "$skill" ~/.claude/skills/bmad-method/$(basename "$skill")
done
```

설치 후 어떤 프로젝트에서든 `/bmad-method:bmad-help` 등으로 호출 가능.

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
