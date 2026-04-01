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

- GitHub: https://github.com/contextprotocol/rtk

## 설치

Homebrew로 설치하며, 텔레메트리(Telemetry) 비활성화를 권장한다.
상세 설정은 공식 저장소의 README를 참고한다.

```bash
brew install rtk

# 텔레메트리 비활성화 권장
export RTK_TELEMETRY_DISABLED=1
```
