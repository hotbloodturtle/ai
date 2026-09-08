# RTK (Rust Token Killer)

> Bash 명령 출력을 압축하여 토큰(Token) 사용량을 60~90% 절감하는 CLI 프록시(Proxy)

## 소개

git, npm, pytest 등 일상적인 개발 명령의 출력을 AI 에이전트에 최적화된 형태로 변환한다.
훅(Hook) 기반 자동 재작성 또는 직접 실행 방식으로 사용할 수 있다.
Claude Code와 함께 사용하면 명령이 자동으로 rtk를 경유하여 토큰을 절감한다.

## 주요 기능

- 자동 출력 압축: git status, git diff, npm test 등
- rtk gain: 토큰 절감량 분석
- rtk gain --history: 명령별 절감 이력 조회
- rtk discover: Claude Code 히스토리에서 절감 기회 분석
- rtk proxy: 필터링 없이 원본 실행 (디버깅용)
- 훅 기반 자동 재작성 (Claude Code) 또는 직접 실행 (rtk git status)

## 공식 링크

- GitHub: https://github.com/rtk-ai/rtk

## 설치

Homebrew로 설치하며, 텔레메트리(Telemetry) 비활성화를 권장한다.
상세 설정은 공식 저장소의 README를 참고한다.

```bash
brew install rtk

# 텔레메트리 비활성화 권장
export RTK_TELEMETRY_DISABLED=1
```

> `RTK_TELEMETRY_DISABLED=1`은 `~/.zshrc` 또는 `~/.claude/settings.json`의 `env`에 넣어야 영구 적용된다 (export만으로는 해당 셸에서만 유효).

---

## Codex

현재 upstream은 [rtk-ai/rtk](https://github.com/rtk-ai/rtk)다. 기존 contextprotocol 링크가 동작하지 않으면 현행 저장소를 사용한다.

```bash
rtk --version
rtk init -g --codex
```

0.40.0에서 검증. `~/.codex/RTK.md`와 `~/.codex/AGENTS.md` 지침을 구성하며 Claude 설정을 패치하지 않는다. Codex에서는 지침에 따라 `rtk ...`를 호출하는 방식으로, Claude의 자동 Bash 재작성 훅과 다르다.

생성된 AGENTS.md가 `@/절대경로/RTK.md` 한 줄뿐이면 Codex용으로 “셸 출력 압축이 필요하면 ~/.codex/RTK.md를 읽고 지원되는 명령에 RTK를 사용한다”는 명시적 문장으로 바꾼다. 다른 개인 규칙은 유지한다. 텔레메트리 설정은 현재 CLI 설명을 확인해 셸 또는 Codex 실행 환경에 적용한다.
