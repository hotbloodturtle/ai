# Ponytail

> "게으른 시니어 개발자(Lazy Senior Dev)" 모드 — 과잉 설계(over-engineering)를 막고 실제로 동작하는 가장 짧고 단순한 해법을 강제하는 플러그인(Plugin)

## 소개

코드를 쓰기 전에 "이게 꼭 필요한가?"부터 묻는 시니어 개발자를 AI 에이전트 안에 넣는다.
YAGNI(You Aren't Gonna Need It), 표준 라이브러리 우선, 요청하지 않은 추상화 금지를 원칙으로,
불필요한 의존성·래퍼 컴포넌트·보일러플레이트 대신 **가장 짧게 동작하는 코드**를 내놓도록 매 응답마다 행동을 교정한다.

RTK가 *명령 출력*을 압축해 토큰을 아낀다면, ponytail은 *생성하는 코드량 자체*를 줄여 비용·시간을 아낀다 → 상호보완적.

## 핵심 원칙: 결정 사다리(Decision Ladder)

코드 작성 전, 먼저 걸리는 단계에서 멈춘다.

1. **이게 존재할 필요가 있나?** → 추측성 요구면 건너뛰고 한 줄로 이유 명시 (YAGNI)
2. **표준 라이브러리로 되나?** → 쓴다
3. **플랫폼 기본 기능으로 되나?** → 쓴다 (`<input type="date">` > 날짜 라이브러리, CSS > JS, DB 제약 > 앱 코드)
4. **이미 설치된 의존성으로 되나?** → 쓴다 (몇 줄로 될 일에 새 의존성 추가 금지)
5. **한 줄로 되나?** → 한 줄
6. **그제서야:** 동작하는 최소한의 코드

## 강도 레벨 (Intensity)

| 레벨 | 동작 |
|------|------|
| **lite** | 요청한 대로 만들되, 더 게으른 대안을 한 줄로 제시. 선택은 사용자 몫 |
| **full** (기본값) | 사다리 강제. 표준/네이티브 우선, 최단 diff·최단 설명 |
| **ultra** | YAGNI 극단주의. 추가보다 삭제. 한 줄짜리 먼저 내놓고 나머지 요구사항 자체를 되묻는다 |

전환: `/ponytail lite|full|ultra|off` · 끄기: `/ponytail off` 또는 "stop ponytail"/"normal mode"

## 안전 가드 (절대 단순화하지 않는 것)

게으름은 "효율"이지 "부주의"가 아니다. 다음은 칼질 대상에서 제외된다:
- 신뢰 경계(trust boundary)의 입력 검증
- 데이터 손실을 막는 에러 처리
- 보안 조치
- 접근성(accessibility) 기본
- 사용자가 명시적으로 요청한 것

벤치마크에서 코드 54% 감축하면서도 **안전성 100% 유지**가 핵심 차별점.

## 명령어 (Claude Code)

| 명령어 | 기능 |
|--------|------|
| `/ponytail [lite\|full\|ultra\|off]` | 강도 레벨 전환 |
| `/ponytail-review` | 현재 diff에서 과잉 설계를 찾아 **삭제 목록** 반환 |
| `/ponytail-audit` | diff가 아닌 **레포 전체** 과잉 설계 스캔 |
| `/ponytail-debt` | 미뤄둔 `ponytail:` 단축 결정들을 **장부(ledger)로 수집** ("나중에"가 "영영"이 되지 않게) |
| `/ponytail-gain` | 절감 효과 스코어보드 표시 |
| `/ponytail-help` | 도움말 |

> 의도적 단순화는 `ponytail:` 주석으로 표시 (`// ponytail: 브라우저에 기본 기능 있음`). 알려진 한계가 있는 단축은 한계와 업그레이드 경로까지 명시 (`# ponytail: 글로벌 락, 처리량 문제 시 계정별 락으로`).

## 측정된 효과

tiangolo `full-stack-fastapi-template`(FastAPI + React) 실제 레포에서 12개 기능 티켓, 동일 에이전트(Haiku 4.5, n=4) 기준, 스킬 없는 baseline 대비:

| 지표 | 변화 |
|------|------|
| 코드량(LOC) | **-54%** (평균, 최대 94%) |
| 토큰 | **-22%** |
| 비용 | **-20%** |
| 시간 | **-27%** |
| 안전성 | **100% 유지** |

> 단순 토큰 최소화가 목표가 아니다. "작업에 필요한 것만 쓰되 검증·에러처리·보안·접근성은 절대 빼지 않는다"의 결과로 코드가 작아질 뿐. GPT-5.5처럼 추론 토큰을 많이 쓰는 모델에선 오히려 비용이 늘 수 있다고 명시(솔직한 한계).

## 동작 방식

Claude Code/Codex에선 **가벼운 Node.js 라이프사이클 훅(lifecycle hook)**으로 매 응답 전 결정 사다리를 주입한다.
다른 에디터(Cursor/Windsurf/Cline 등)는 룰 파일 복사 방식. 멀티 플랫폼 지원(Claude Code, Codex, Copilot CLI, Gemini, OpenCode, Pi 등).

## 공식 링크

- GitHub: https://github.com/DietrichGebert/ponytail
- 라이선스: MIT ("동작하는 가장 짧은 라이선스")

## 설치 (Claude Code 기준)

```bash
/plugin marketplace add DietrichGebert/ponytail
/plugin install ponytail@ponytail
```

데스크톱 앱은 `/plugin` 명령이 없으므로 UI에서 설치: Customize → 개인 플러그인 옆 `+` → Create plugin and add marketplace → Add from repository → 레포 URL 입력.

## 설치 확인

- 설치 경로: `~/.claude/plugins/cache/ponytail/ponytail/<버전>` (`installed_plugins.json`에서 활성 버전 확인).
- 구성: **명령어 6개**(`commands/*.toml`) + **스킬 6개**(`skills/*/SKILL.md`: ponytail, -audit, -debt, -gain, -help, -review) + **라이프사이클 훅 5개**(`hooks/ponytail-*.js`, `plugin.json` → `hooks/claude-codex-hooks.json` 참조). MCP 서버(`ponytail-mcp/`)도 동봉되나 Claude Code 플러그인은 훅 기반으로 동작.
- 세션 시작 시 SessionStart 훅이 "PONYTAIL MODE ACTIVE" 컨텍스트를 주입하면 정상.

## 검증된 함정

- **마켓플레이스 클론의 버전 표기**: `~/.claude/plugins/marketplaces/ponytail`의 `package.json` 버전은 실제 활성 버전과 다를 수 있다 — **캐시 디렉터리(`plugins/cache/.../<버전>`)가 기준**이다(혼동 주의).
- **nvm node와 비대화형 셸 PATH**: 훅이 Node.js로 도는데, README가 "Nix/nvm 사용자는 *비대화형 셸 PATH*에 node가 있어야 한다"고 경고한다. node를 nvm 등으로 관리하는 기기는 `zsh -c 'command -v node'`로 비대화형 셸에서도 node가 잡히는지 확인할 것. node가 PATH에 없는 환경(예: GUI 직접 실행, cron)에서 Claude Code를 띄우면 always-on 활성화 훅이 조용히 비활성화된다(스킬 자체는 동작). 그런 환경에선 `~/.claude/settings.json`의 `env`나 셸 초기화로 node PATH를 보장할 것.
