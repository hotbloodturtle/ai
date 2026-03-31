# Codex Master Setup Document Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 개인용 macOS 기준의 설치 중심 Codex 셋업 문서를 만들고, 운영 규약까지 함께 정리한다.

**Architecture:** 루트에 실행형 문서 하나를 두고, 설계/계획 문서는 `docs/plans/`에 분리 저장한다. 본문은 설치와 검증을 중심으로 쓰고, Claude 전용 개념은 대응표와 주의사항으로 재해석한다.

**Tech Stack:** Markdown, Codex CLI, local shell verification, MCP configuration, Playwright CLI, RTK, AGENTS.md conventions

---

### Task 1: 설계/계획 문서 생성

**Files:**
- Create: `docs/plans/2026-03-31-codex-master-setup-design.md`
- Create: `docs/plans/2026-03-31-codex-master-setup-plan.md`

**Step 1: 설계 문서 작성**

승인된 문서 방향, 목표, 비목표, 섹션 구조를 정리한다.

**Step 2: 계획 문서 작성**

실제 문서 작성 단계를 2~5분 단위 작업으로 쪼갠다.

**Step 3: 파일 생성 확인**

Run: `ls docs/plans/2026-03-31-codex-master-setup-*.md`
Expected: 설계 문서와 계획 문서가 모두 보인다.

### Task 2: 개념 정리와 호환성 섹션 작성

**Files:**
- Modify: `codex-master-setup.md`

**Step 1: 개념 표 작성**

`Codex CLI`, `AGENTS.md`, `skills`, `MCP`, `config.toml`, `subagent`, `plugin`의 역할을 정의한다.

**Step 2: Claude 대비 표 작성**

`그대로 가능 / 부분 가능 / 재해석 필요`로 구분해 Claude 개념과 Codex 개념을 대응시킨다.

**Step 3: 사실성 검증**

Run: `codex --help | sed -n '1,80p'`
Expected: `exec`, `review`, `mcp`, `resume`, `fork` 같은 핵심 명령이 보인다.

### Task 3: 설치와 설정 섹션 작성

**Files:**
- Modify: `codex-master-setup.md`

**Step 1: 빠른 설치 섹션 작성**

개인용 Mac 기준 최소 설치 경로를 작성한다.

**Step 2: 상세 설치 섹션 작성**

`config.toml`, 프로젝트 trust, `AGENTS.md`, `skills`, `MCP`, `playwright-cli`, `android-qa-agent`를 순서대로 정리한다.

**Step 3: 비밀값 안전 처리**

`config.toml` 예시에 placeholder만 남기고 실제 토큰/키는 넣지 않는다.

**Step 4: 설치 명령 검증**

Run: `codex mcp add --help | sed -n '1,120p'`
Expected: `--url`, `--env`, stdio command 형태가 모두 보인다.

### Task 4: 검증/운영/트러블슈팅 섹션 작성

**Files:**
- Modify: `codex-master-setup.md`

**Step 1: 정적 검증 체크리스트 작성**

버전, 파일, MCP, 스킬, 보조 도구를 점검하는 명령 목록을 작성한다.

**Step 2: 행동 검증 시나리오 작성**

`AGENTS.md` 적용, MCP 인식, 병렬 에이전트, 브라우저 테스트 같은 실제 동작 검증 시나리오를 적는다.

**Step 3: 개인 운영 프로필 작성**

사용자 프롬프트를 Codex용 규약으로 정리한다.

**Step 4: 트러블슈팅 작성**

`RTK 자동 훅`, `serena/frontend-design 부재`, `MCP 비밀값`, `npx/uv` 의존성, 재시작 필요 같은 현실적 이슈를 정리한다.

### Task 5: 최종 검토 및 안전성 확인

**Files:**
- Modify: `codex-master-setup.md`

**Step 1: 민감값 스캔**

Run: `rg -n "sbp_|sntryu_|figd_[A-Za-z0-9]|sntryu_[A-Za-z0-9]|ASANA_ACCESS_TOKEN = \\\"" codex-master-setup.md`
Expected: 실제 비밀값 패턴이 매치되지 않는다.

**Step 2: 문서 구조 확인**

Run: `rg -n "^## " codex-master-setup.md`
Expected: 설계에서 정한 주요 섹션이 모두 존재한다.

**Step 3: 내용 검토**

Run: `sed -n '1,260p' codex-master-setup.md`
Expected: 설치 우선 구조가 앞부분에 보이고, 운영 원칙은 뒤쪽에 배치된다.

**Step 4: Commit**

```bash
git add docs/plans/2026-03-31-codex-master-setup-design.md \
        docs/plans/2026-03-31-codex-master-setup-plan.md \
        codex-master-setup.md
git commit -m "docs: add personal codex setup guide"
```
