# Claude HUD

> Claude Code 세션 내부 상태(컨텍스트 사용량, 실행 중 도구/에이전트, 할 일 진행률)를 터미널 상태줄(statusline)에 실시간 표시하는 플러그인

- 저장소: https://github.com/jarrodwatts/claude-hud

## 소개

Claude Code는 기본적으로 "지금 무슨 일이 일어나는지"를 잘 보여주지 않는다.
Claude HUD는 statusline을 HUD(Head-Up Display)로 바꿔 세션 상태를 한 줄로 보여준다:

- 프로젝트 경로 + git 브랜치/변경 상태
- **컨텍스트 윈도우 사용률** (시각적 바 + %) — 컴팩션 타이밍 예측에 유용
- 토큰 소비량, rate limit 잔량
- 현재 실행 중인 도구 (읽는 파일, 편집, 검색 등)
- 실행 중인 서브에이전트 상태/진행률
- Todo 진행률, 세션 경과 시간, 출력 속도

## 요구사항

- Claude Code v1.0.80+
- macOS/Linux: Node.js 18+ 또는 Bun / Windows: Node.js 18+

## 설치

```
/plugin marketplace add jarrodwatts/claude-hud
/plugin install claude-hud
/claude-hud:setup        # statusline 자동 설정
```

또는 CLI에서:

```bash
claude plugin marketplace add jarrodwatts/claude-hud
claude plugin install claude-hud@claude-hud
```

## 설정

- `/claude-hud:configure` — 가이드 설정. 프리셋: **Full**(전부) / **Essential**(활동+git) / **Minimal**(모델+컨텍스트 바만)
- 수동: `~/.claude/plugins/claude-hud/config.json` 편집 (색상, 임계값, 표시 항목)

## 이 머신의 실제 설치 상태 (2026-07-06 검증)

- v0.3.0 설치 완료 (`~/.claude/plugins/cache/claude-hud/claude-hud/0.3.0/`)
- 런타임: Bun (`src/index.ts` 직접 실행 — node보다 빠름)
- `/claude-hud:setup`의 인라인 bash 원라이너는 중첩 따옴표(`'"'"'`)가 JSON 저장을 거치며 깨지기 쉬워,
  래퍼 스크립트 방식으로 설정함:
  - `~/.claude/claude-hud-statusline.sh` — 터미널 폭 감지 + 최신 플러그인 버전 자동 탐색 + bun 실행
  - `~/.claude/settings.json`의 `statusLine.command` → 위 스크립트 호출
- 스모크 테스트 통과 (모델명 + 컨텍스트 바 정상 렌더링)
- 참고: ponytail 플러그인의 statusline 배지와 상호 배타적 (statusLine은 하나만 가능) → claude-hud 채택

## 팁

- Linux에서 `/tmp`가 noexec 등으로 제한된 경우 설치 전 `TMPDIR` 지정 필요
- 플러그인 업데이트 시 래퍼 스크립트가 버전 디렉터리를 자동 탐색하므로 재설정 불필요
