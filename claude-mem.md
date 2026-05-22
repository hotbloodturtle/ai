# Claude-Mem

> 세션 간 영속 메모리: 에이전트가 한 일을 자동으로 압축·저장하고 다음 세션에 다시 주입

## 소개

Claude-Mem은 Claude Code 같은 에이전트의 작업 컨텍스트를 세션이 끝나도 유지시켜 주는 메모리 시스템이다. 라이프사이클 훅으로 세션 중 관찰(observation)을 캡처하고, AI로 의미 단위 요약을 만들어 SQLite + 벡터 DB에 저장한 뒤, 다음 세션 시작 시 관련 컨텍스트를 자동으로 주입한다.

`/resume`이 직전 메시지 히스토리를 그대로 잇는다면, Claude-Mem은 **새 세션에 압축된 요약만 얹어주는** 별도 레이어다. 그래서 토큰을 아끼면서 "어제 하던 프로젝트"를 자연스럽게 이어갈 수 있다.

## 주요 기능

- 5개 라이프사이클 훅(SessionStart, UserPromptSubmit, PostToolUse, Stop, SessionEnd)으로 자동 관찰·요약·주입
- 워커 서비스(HTTP API + 웹 뷰어, 기본 포트 `37701`)를 Bun으로 관리
- SQLite + FTS5 풀텍스트 검색 + Chroma 벡터 DB 하이브리드 검색
- MCP 검색 도구 4개로 토큰 효율적 3-layer 워크플로 (`search` → `timeline` → `get_observations`, 약 10배 토큰 절감)
- mem-search 스킬로 자연어 질의
- `<private>` 태그로 민감 내용 저장 제외
- 프로젝트(디렉토리) 단위 메모리 격리
- 다국어 모드 지원 (`code`, `code--zh`, `code--ja` 등)
- Claude Code 외 Gemini CLI, OpenCode, OpenClaw 등 호환

## 공식 링크

- GitHub: https://github.com/thedotmack/claude-mem
- 문서: https://docs.claude-mem.ai/
- 웹 뷰어 (설치 후): http://localhost:37701

## 설치

```bash
npx claude-mem install
```

또는 Claude Code 플러그인 마켓:

```bash
/plugin marketplace add thedotmack/claude-mem
/plugin install claude-mem
```

설치 후 워커 시작이 필요할 수 있다(설치 로그에 "Worker autostart skipped" 표시되는 경우):

```bash
npx claude-mem start
```

헬스 체크:

```bash
curl http://localhost:37701/health   # {"status":"ok",...}
```

### 자동 등록되는 항목 (Claude Code 기준)
- 플러그인 디렉토리: `~/.claude/plugins/marketplaces/thedotmack`
- 데이터 디렉토리: `~/.claude-mem`
- 설정 파일: `~/.claude-mem/settings.json` (첫 실행 시 자동 생성)
- 런타임 의존성: Bun, uv (없으면 자동 설치)

설치 후 Claude Code 재시작 1회.

## 사용 패턴

| 상황 | 추천 |
|------|------|
| 평소 사용 (켜고 끄기) | 그냥 자연스럽게 종료/재시작 — SessionEnd → SessionStart 훅이 자동 처리 |
| 방금 작업을 메시지 그대로 잇기 | `/resume` |
| 하루 이상 텀, 같은 프로젝트 복귀 | 그냥 새 세션 → Claude-Mem이 요약 주입 (토큰 절약) |
| 첫 세션 | 관찰만 쌓는 단계, 주입 효과는 두 번째 세션부터 |
| 전체 리포 미리 학습 | 새 세션에서 `/learn-codebase` (~5분, 선택) |

## 참고

- ⚠️ `npm install -g claude-mem`은 **SDK/라이브러리만** 설치되어 훅·워커가 등록되지 않음. 반드시 `npx claude-mem install` 또는 플러그인 마켓 경로로 설치.
- 워커가 꺼져 있으면 관찰 저장도, 컨텍스트 주입도 동작 안 함. 자동 시작이 안 되면 로그인 항목/launchd 등으로 띄워두는 게 편함.
- 정상 종료(Ctrl+C, `/exit`) 시에만 SessionEnd 훅이 돌면서 요약이 저장됨. 터미널 강제 종료 시 그 세션 요약은 손실될 수 있음.
- 제거 시 모든 Claude Code 세션을 닫고 진행해야 함 — 활성 훅이 `~/.claude-mem`을 재생성함.
- 자동 분류기(auto mode)는 `npx claude-mem` 같은 외부 코드 실행을 차단할 수 있음. 설치/시작 명령은 사용자가 직접 실행하거나, 명시적 승인이 필요할 수 있음.
- README에는 워커 포트가 `37777`로 적혀 있으나 v13.3.0 기준 실제 포트는 **`37701`**.
- `CLAUDE_CODE_DISABLE_AUTO_MEMORY=1` 환경변수는 Claude Code 내장 auto-memory를 끄는 옵션으로, Claude-Mem과는 별개 시스템이며 동작에 영향 없음.
