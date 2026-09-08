# gstack

> 29개 전문 역할의 가상 엔지니어링 팀을 AI 에이전트에게 부여하는 스킬

## 소개

gstack은 CEO, 디자이너, 엔지니어, QA, 보안 전문가 등 29개 역할을 에이전트에게 부여하는 스킬이다.
역할별 전문 지식을 활용하여 소프트웨어 개발의 전 과정을 종합적으로 지원한다.
플랫폼에 독립적인 구조로, 다양한 AI 코딩 에이전트에서 활용 가능하다.

## 주요 기능

- 29개 전문 역할 (CEO 리뷰, 디자인 컨설팅, 엔지니어 리뷰, QA, 보안 감사 등)
- /browse: 헤드리스 브라우저(Headless Browser)로 QA 테스트, 사이트 점검
- /ship: PR 생성, 테스트, 배포 워크플로(Workflow)
- /investigate: 체계적 디버깅(Debugging) + 근본 원인 분석
- /design-review: 디자이너 관점 시각 QA
- /office-hours: YC 오피스 아워 스타일 브레인스토밍(Brainstorming)
- /retro: 주간 엔지니어링 회고(Retrospective)
- /qa, /qa-only: 웹 앱 QA 테스트 + 자동 수정 또는 보고서만

## 공식 링크

- GitHub: https://github.com/garrytan/gstack

## 설치

### 사전 요구사항
- Git
- **Bun v1.0+ 필수** — gstack의 browse 바이너리 빌드에 사용
- Node.js (Windows만)

### Bun 설치
```bash
curl -fsSL https://bun.sh/install | bash
source ~/.zshrc
```

### gstack 설치 (공식 권장 방식)
```bash
git clone --single-branch --depth 1 https://github.com/garrytan/gstack.git ~/.claude/skills/gstack
cd ~/.claude/skills/gstack && ./setup
```

`./setup`이 자동 처리:
- Chrome / FFmpeg / Headless Shell 다운로드 (~250MB)
- 47개 슬래시 커맨드 자동 등록 (autoplan, browse, qa, ship, review, /office-hours 등)
- browse 바이너리 빌드

### 팀 모드 (저장소 공유)
```bash
(cd ~/.claude/skills/gstack && ./setup --team) && \
  ~/.claude/skills/gstack/bin/gstack-team-init required && \
  git add .claude/ CLAUDE.md && \
  git commit -m "require gstack for AI-assisted work"
```

### 검증된 함정
- gstack은 **단일 디렉토리** 형태로 `~/.claude/skills/gstack`에 통째로 설치되어야 함 (개별 스킬 분할 심링크 X).
- ~/.claude/plugins/repos/에 클론한 후 심링크하는 방식도 동작하지만, `./setup`은 디렉토리 기준으로 동작하므로 setup 스크립트 직접 실행 필요.

## 참고

- 업데이트: `/gstack-upgrade` 슬래시 커맨드

---

## Codex

현재 [upstream](https://github.com/garrytan/gstack)은 Codex 전용 host를 지원한다. Claude 설치와 독립 체크아웃을 사용한다.

```bash
mkdir -p "$HOME/.local/share/ai-tools"
git clone --single-branch --depth 1 https://github.com/garrytan/gstack.git "$HOME/.local/share/ai-tools/gstack"
cd "$HOME/.local/share/ai-tools/gstack"
./setup --host codex
```

Bun이 필요하다. setup은 의존성·브라우저 바이너리와 Codex용 `gstack-*` 스킬을 `${CODEX_HOME:-~/.codex}/skills/`에 구성한다. 현재 config.toml의 모델을 읽어 지침을 생성하므로 모델 변경 후 같은 setup을 다시 실행한다. Claude용 기본 setup 또는 `--host auto`를 Codex 전용 설치에 사용하지 않는다.

setup 성공과 브라우저 런타임 확인을 검증했다. 일부 워크플로는 별도의 외부 계정/도구 또는 Claude 호출 기능을 포함할 수 있으므로, 모든 gstack 기능이 OpenAI만으로 실행된다고 가정하지 않는다. 사용하려는 스킬의 요구사항을 확인한다. setup은 공유 브라우저 캐시도 갱신할 수 있다.
