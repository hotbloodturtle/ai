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

### 1.0 변경 사항 (2026-10-23 1.0.1 확인)
- `rtk proxy <cmd>` → **`rtk bypass <cmd>`** (옛 이름은 별칭으로 계속 동작), `--ultra-compact` 제거, `rtk gain` 헤드라인 비율에서 너무 큰 출력 제외.
- **라이선스**: CLI 본체는 Apache-2.0 그대로, 엔진·프록시 구성요소는 **BSL 1.1**. 실사용은 무료(개인·회사 포함), 다른 사람에게 유료·호스팅 서비스로 제공하는 것만 금지. 2030-09-09에 Apache-2.0 전환.
- Claude Code 훅 명령(`rtk hook claude`)은 그대로 — `settings.json` 수정 불필요.

> `RTK_TELEMETRY_DISABLED=1`은 `~/.zshrc` 또는 `~/.claude/settings.json`의 `env`에 넣어야 영구 적용된다 (export만으로는 해당 셸에서만 유효).
