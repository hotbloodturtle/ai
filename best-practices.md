# Claude Code 베스트 프랙티스

> AI 코딩 에이전트 활용 실전 팁 모음 (69개 팁에서 핵심 선별)

출처: [shanraisshan/claude-code-best-practice](https://github.com/shanraisshan/claude-code-best-practice)

## 전역 적용 방법

핵심 규칙을 `~/.claude/rules/ai-workflow.md`에 배치하면 모든 세션에서 자동 적용된다.

```bash
# 1. 이 파일에서 핵심만 추출한 규칙 파일 생성
cp <이 프로젝트>/best-practices-rules.md ~/.claude/rules/ai-workflow.md

# 2. ~/.claude/CLAUDE.md의 세부 규칙 섹션에 추가
# @rules/ai-workflow.md
```

현재 적용된 전역 규칙: CLAUDE.md 관리, 스킬 작성, 워크플로, Git/PR (24줄)

---

## CLAUDE.md 작성법

- 파일당 **200줄 이하** 유지. 길어지면 무시될 확률 증가
- 도메인별 규칙은 `<important if="...">` 조건부 태그로 감싸기
- 모노레포(Monorepo)는 **다중 CLAUDE.md** 활용 (조상→자손 로딩)
- 지시가 많으면 `.claude/rules/`로 분리
- "테스트 실행" 한 마디에 즉시 동작해야 함 — 안 되면 CLAUDE.md에 빌드/테스트 명령 누락
- 하네스(Harness)로 강제할 수 있는 건 CLAUDE.md 대신 **settings.json** 사용 (attribution, permissions, model 등)
- 코드베이스를 깨끗하게 유지하고 마이그레이션은 끝까지 완료 — 절반만 된 마이그레이션은 모델을 혼란시킴

## 스킬 (Skill)

- `context: fork`로 격리된 서브에이전트에서 실행 — 메인 컨텍스트는 최종 결과만 수신
- 스킬은 **폴더 구조**로 관리 (`references/`, `scripts/`, `examples/` 하위 디렉토리)
- **Gotchas 섹션** 필수 — Claude가 반복 실패하는 포인트를 축적
- description 필드는 요약이 아니라 **트리거** — "언제 발동해야 하나?"로 작성
- 당연한 내용 금지, Claude의 기본 행동에서 **벗어나게 하는 것**만 기술
- 단계별 지시(prescriptive steps) 대신 **목표와 제약**을 부여
- 스킬에 스크립트/라이브러리 포함 → Claude가 재구성 대신 **조합**하게 함
- `` !`command` ``로 동적 셸 출력을 프롬프트에 주입 가능

## 커맨드 (Command)

- 하루 **1번 이상 반복**하면 스킬 또는 커맨드로 만들기
- 매일 쓰는 "inner loop" 워크플로는 슬래시 커맨드로 — `.claude/commands/`에 저장, git 커밋
- 서브에이전트보다 커맨드가 적합한 경우가 많음

## 훅 (Hook)

- `/careful`, `/freeze` 같은 **온디맨드(On-demand) 훅**으로 안전성 확보
- PreToolUse 훅으로 **스킬 사용량 측정** — 인기/미발동 스킬 파악
- PostToolUse 훅으로 **자동 포맷팅** — Claude가 90%, 훅이 나머지 10% 처리
- Stop 훅으로 턴 종료 시 **검증 넛지(Nudge)** 추가

## 워크플로 (Workflow)

- 컴팩션(Compaction) 50%에서 수동 `/compact` 실행. 태스크 전환 시 `/clear`
- 작은 태스크는 바닐라 Claude Code가 어떤 워크플로보다 나음
- `/model`로 모델/추론 선택, `/context`로 컨텍스트 확인, `/usage`로 사용량 체크
- **plan mode는 Opus, 코드 작성은 Sonnet** 조합 권장
- thinking mode 항상 켜기 + Output Style Explanatory로 추론 과정 확인
- `ultrathink` 키워드로 고강도 추론 유도
- `/rename`으로 중요 세션 라벨링 → `/resume`으로 이어 작업
- Esc Esc 또는 `/rewind`로 탈선 시 되돌리기 (같은 컨텍스트에서 수습 시도보다 효과적)

## 워크플로 고급

- ASCII 다이어그램으로 아키텍처 이해
- `/loop`은 로컬 반복 모니터링 (최대 3일), `/schedule`은 클라우드 반복 태스크
- `/permissions`에 와일드카드 구문 사용 (`Bash(npm run *)`, `Edit(/docs/**)`)
- `/sandbox`로 파일/네트워크 격리 → 권한 프롬프트 84% 감소
- 제품 검증 스킬(signup-flow-driver, checkout-verifier)에 투자할 가치 있음

## Git / PR

- PR은 **작고 집중적으로** — p50 기준 118줄, 기능 하나당 PR 하나
- 항상 **squash merge** — 깔끔한 선형 히스토리, `git revert`/`git bisect` 용이
- **매시간 커밋** — 태스크 완료 즉시 커밋
- `/code-review`로 멀티 에이전트 PR 분석 — 버그, 보안 취약점, 리그레션(Regression) 사전 탐지

## 디버깅 (Debugging)

- 막힐 때마다 **스크린샷 공유**를 습관화
- MCP (Playwright, Chrome DevTools)로 Claude가 직접 콘솔 로그 확인
- 로그 확인용 터미널은 **백그라운드 태스크**로 실행
- `/doctor`로 설치/인증/설정 문제 진단
- 컴팩션 중 에러 → `/model`로 1M 토큰 모델 선택 후 `/compact`
- 크로스 모델(Cross-model) QA — 예: Codex로 플랜/구현 리뷰

## 일상 루틴

- Claude Code **매일 업데이트**
- 하루 시작을 **changelog 읽기**로
