# 갭 분석 보고서 (Gap Analysis)

> master-setup.md 가이드와 실제 설치 상태 간 12개 불일치 사항 분석
>
> 검증 일자: 2026-03-28

---

## 요약

| 구분 | 갭 수 | 해결됨 | 미해결 |
|------|-------|--------|--------|
| 플러그인 | 4 | 3 | 1 |
| MCP 서버 | 2 | 1 | 1 |
| 설정 파일 | 3 | 3 | 0 |
| 훅/경로 | 2 | 2 | 0 |
| 스킬 | 1 | 1 | 0 |
| **합계** | **12** | **10** | **2** |

---

## 갭 상세 설명

### 갭 1: example-skills + document-skills 중복 활성화

| 항목 | 내용 |
|------|------|
| **현상** | `enabledPlugins`에 `document-skills`와 `example-skills` 두 개가 모두 활성화 |
| **원인** | `anthropics/skills` 레포에서 두 이름이 동일한 플러그인을 가리킴 (같은 커밋 해시 `98669c11ca63`) |
| **영향** | 동일 스킬이 두 번 로드되어 슬래시 명령어 목록에 중복 표시 |
| **해결** | `example-skills@anthropic-agent-skills` 비활성화, `document-skills`만 유지 |
| **상태** | 해결됨 (settings.json에서 example-skills 키 제거) |

---

### 갭 2: frontend-design 마켓플레이스 이름 불일치

| 항목 | 내용 |
|------|------|
| **현상** | 가이드 초기 버전에서 `frontend-design@claude-code-plugins`로 기재, 실제 설치 시 실패 |
| **원인** | `claude-code-plugins` 마켓(`anthropics/claude-code` 레포)에는 플러그인이 없음. 실제로는 `claude-plugins-official`에 존재 |
| **영향** | 가이드대로 설치 시 "Plugin not found in marketplace" 오류 |
| **해결** | `frontend-design@claude-plugins-official`로 수정. 마켓 미지정(`claude plugin install frontend-design`)으로도 자동 탐색 가능 |
| **상태** | 해결됨 (가이드 수정 + settings.json 보정) |

---

### 갭 3: MCP 서버가 settings.json에 미표시

| 항목 | 내용 |
|------|------|
| **현상** | Context7, Task Master, Codebase Memory MCP 서버가 `settings.json`에 보이지 않음 |
| **원인** | `claude mcp add --scope user`로 추가된 MCP 서버는 별도 파일(`~/.claude/.mcp.json` 또는 프로젝트 레벨 `.mcp.json`)에 저장됨. `settings.json`은 플러그인/훅/권한만 관리 |
| **영향** | settings.json만 보면 MCP 서버 설정이 누락된 것으로 오해 가능 |
| **해결** | `claude mcp list`로 실제 등록 상태 확인. MCP 서버 설정은 프로젝트 레벨(`.mcp.json`) 또는 사용자 레벨에 별도 저장됨을 가이드에 명시 |
| **상태** | 부분 해결 (가이드에 설명 추가, 구조 변경 불가) |

---

### 갭 4: swift-lsp 활성화되어 있으나 필수 목록에 없음

| 항목 | 내용 |
|------|------|
| **현상** | `swift-lsp@claude-plugins-official`가 settings.json에 활성화되어 있으나, "추천 설정 조합"이나 "빠른 설치 가이드"의 필수 항목에 미포함 |
| **원인** | Swift 개발이 현재 주 작업이 아니지만 설치 과정에서 추가됨 |
| **영향** | 불필요한 플러그인 로딩으로 인한 미미한 오버헤드 |
| **해결** | Swift 개발하지 않는 경우 비활성화 가능. 가이드에 "선택(Optional)" 분류로 명시 |
| **상태** | 해결됨 (분류 정리 완료, 제거 여부는 사용자 판단) |

---

### 갭 5: RTK 훅 경로 하드코딩 (절대 경로)

| 항목 | 내용 |
|------|------|
| **현상** | settings.json의 RTK 훅 경로가 `/Users/<사용자명>/.claude/hooks/rtk-rewrite.sh`로 절대 경로 하드코딩 |
| **원인** | `rtk init -g`가 생성하는 훅 설정이 사용자 홈 디렉토리를 절대 경로로 기록 |
| **영향** | 다른 사용자나 다른 macOS 계정으로 설정 복사 시 경로 불일치로 훅 실행 실패 |
| **해결 방법 1** | `~/.claude/hooks/rtk-rewrite.sh` (틸드 경로) 사용 -- 단, Claude Code의 훅 실행기가 틸드 확장을 지원하는지 확인 필요 |
| **해결 방법 2** | 환경변수 사용: `$HOME/.claude/hooks/rtk-rewrite.sh` |
| **참고** | CBM 게이트 훅은 `~/.claude/hooks/cbm-code-discovery-gate`로 틸드 경로 사용 중이므로, RTK도 동일 형식 적용 가능 |
| **상태** | 해결됨 (가이드에서 `<사용자명>` 자리표시자를 실제 사용자명으로 교체하도록 안내) |

---

### 갭 6: Codebase Memory 설치 스크립트가 settings.json 덮어쓰기

| 항목 | 내용 |
|------|------|
| **현상** | `curl ... install.sh | bash` 실행 시 settings.json이 CBM 훅만 포함한 상태로 생성/덮어쓰기 |
| **원인** | 설치 스크립트가 기존 settings.json 병합이 아닌 새로 생성하는 경우 있음 |
| **영향** | 기존 플러그인 설정, RTK 훅, permissions 등이 유실될 수 있음 |
| **해결** | 설치 순서 조정: 플러그인 먼저 설치 → CBM 설치 → RTK 설치 → 최종 settings.json 보정 |
| **상태** | 해결됨 (가이드의 Step 8에서 최종 보정 단계 명시) |

---

### 갭 7: settings.json에 중복 키 발생

| 항목 | 내용 |
|------|------|
| **현상** | `enabledPlugins`에 `frontend-design@claude-code-plugins`와 `frontend-design@claude-plugins-official` 동시 존재 |
| **원인** | settings.json 수동 작성 후 `claude plugin install`이 실제 마켓 기준으로 키를 자동 추가 |
| **영향** | 존재하지 않는 마켓의 키가 남아 있으면 경고 로그 발생 가능 |
| **해결** | `frontend-design@claude-code-plugins` 키 제거, `frontend-design@claude-plugins-official`만 유지 |
| **상태** | 해결됨 (settings.json 보정 완료) |

---

### 갭 8: Serena MCP 연결 실패

| 항목 | 내용 |
|------|------|
| **현상** | `claude mcp list`에서 `plugin:serena:serena: Failed to connect` |
| **원인** | Serena 플러그인은 `uvx` 명령어로 MCP 서버를 실행하는데, `uv` (Python 패키지 실행 도구)가 미설치 |
| **영향** | Serena의 시맨틱 코드 분석 기능 전체 사용 불가 |
| **해결** | `brew install uv` 실행 후 Claude Code 재시작 |
| **상태** | 해결됨 (가이드에 uv 사전 설치 안내 추가) |

---

### 갭 9: Claude SEO Python 버전 불일치

| 항목 | 내용 |
|------|------|
| **현상** | `install.sh`가 `python3`를 호출하지만 macOS 시스템 Python(3.9)이 우선 사용됨 |
| **원인** | `brew install python@3.12` 후에도 PATH에서 시스템 Python이 우선 |
| **영향** | install.sh 실패 ("Python 3.10+ is required") |
| **해결 1** | 스킬 파일만 수동 복사 (DataForSEO MCP 제외) |
| **해결 2** | `sed 's/python3/python3.12/g' install.sh`로 경로 치환 후 실행 |
| **상태** | 해결됨 (가이드에 두 가지 우회 방법 명시) |

---

### 갭 10: Context7 설치 명령어 대화형 프롬프트

| 항목 | 내용 |
|------|------|
| **현상** | `npx ctx7 setup --claude`가 MCP/CLI 선택 프롬프트 표시, 비대화형 환경에서 멈춤 |
| **원인** | ctx7 setup 스크립트가 대화형 입력을 요구 |
| **영향** | 자동화 스크립트에서 설치 중단 |
| **해결** | `claude mcp add --scope user context7 -- npx -y @upstash/context7-mcp@latest`로 직접 추가 |
| **상태** | 해결됨 (가이드에 직접 추가 명령어 명시) |

---

### 갭 11: gstack /review와 커스텀 /review 이름 충돌

| 항목 | 내용 |
|------|------|
| **현상** | gstack 설치 후 `/review` 입력 시 gstack의 Staff Engineer 리뷰(61KB)가 호출됨 |
| **원인** | gstack setup이 `~/.claude/skills/`에 심링크를 생성하면서 기존 커스텀 review를 덮어쓰거나 우선순위에서 밀림 |
| **영향** | 간단한 버그/성능/보안 체크 의도로 `/review`를 사용할 수 없음 |
| **해결** | 커스텀 review 스킬의 name을 `quick-review`로 변경 |
| **상태** | 해결됨 (커스텀 스킬 이름 변경 안내) |

---

### 갭 12: RTK 텔레메트리 기본 활성 상태

| 항목 | 내용 |
|------|------|
| **현상** | `rtk init -g` 후에도 텔레메트리가 활성 (호스트명+사용자명 해시, 사용 명령어 외부 전송) |
| **원인** | RTK 기본 설정이 텔레메트리 활성. 비활성화는 환경변수 설정 필요 |
| **영향** | 사용자 모르게 사용 데이터 외부 전송 + 로컬 DB에 90일간 평문 저장 |
| **해결** | `export RTK_TELEMETRY_DISABLED=1`을 `~/.zshrc`에 추가 |
| **상태** | 해결됨 (가이드에 필수 단계로 포함) |

---

## 해결 상태 요약

| # | 갭 | 이 패키지로 해결 | 비고 |
|---|---|:---:|------|
| 1 | example-skills 중복 | O | settings.json에서 제거 |
| 2 | frontend-design 마켓 이름 | O | claude-plugins-official로 수정 |
| 3 | MCP 서버 settings.json 미표시 | -- | 구조적 한계 (별도 파일에 저장됨) |
| 4 | swift-lsp 분류 누락 | O | 선택(Optional)으로 분류 |
| 5 | RTK 절대 경로 하드코딩 | O | 가이드에 교체 안내 |
| 6 | CBM 설치가 settings.json 덮어쓰기 | O | 설치 순서 + Step 8 보정 |
| 7 | settings.json 중복 키 | O | 보정 방법 명시 |
| 8 | Serena uv 미설치 | O | brew install uv 안내 |
| 9 | Claude SEO Python 버전 | O | 수동 복사 또는 경로 치환 |
| 10 | Context7 대화형 프롬프트 | O | 직접 mcp add 명령어 |
| 11 | gstack review 이름 충돌 | O | 커스텀 스킬 이름 변경 |
| 12 | RTK 텔레메트리 | O | 환경변수 비활성화 |

---

## 권장 조치

1. **즉시 조치**: 갭 1, 2, 5, 7 -- settings.json 수정으로 해결
2. **설치 시 주의**: 갭 3, 6, 8, 9, 10 -- 설치 순서와 사전 의존성 확인
3. **선택 조치**: 갭 4, 11, 12 -- 사용자 환경에 맞게 선택

> 참조: `claude-code-master-setup.md` > "실제 설치 시 트러블슈팅" 섹션

---

## 하네스 엔지니어링 관점의 추가 갭

### 참고 자료
- "하네스 엔지니어링 완전정복 V1.1" (@shuntailor, 139p)
- 핵심 프레임워크: CIVC 4대 기둥 (Constrain, Inform, Verify, Correct)

### 추가 식별된 갭

| # | 갭 | 심각도 | 상태 | 설명 |
|---|---|--------|------|------|
| 13 | AGENTS.md 템플릿 없음 | 중간 | **해결** | project-template/AGENTS.md 추가 (60줄 원칙 적용) |
| 14 | Verification Plan 미포함 | 중간 | **해결** | project-template/CLAUDE.md에 검증 계획 섹션 추가 |
| 15 | 보안 5계층 모델 미적용 | 낮음 | 참고 | Prompt > Schema > Runtime > Tool > Hooks 순서. 현재 Hooks 계층만 설정됨 (RTK+CBM). 나머지는 프로젝트별로 적용 |
| 16 | 둠 루프 방지 미설정 | 낮음 | 참고 | 같은 에러 3회 반복 시 중단하는 규칙은 CLAUDE.md에 추가 권장 |
| 17 | 비용 모니터링 없음 | 낮음 | 참고 | 태스크별 토큰 예산 (버그 50K, 기능 200K, 리팩토링 500K) 적용 권장 |

### CIVC 4대 기둥 현재 적용 상태

| 기둥 | 현재 적용 | 개선 가능 |
|------|----------|----------|
| **Constrain (제약)** | permissions.deny 비어 있음, hooks 2개 | .env 읽기 차단 추가, PostToolUse lint 훅 권장 |
| **Inform (알림)** | CLAUDE.md + rules 4개 + RTK.md | path-specific rules 추가 권장 |
| **Verify (검증)** | 없음 (수동) | Verification Plan 템플릿 추가됨 |
| **Correct (수정)** | 없음 | 둠 루프 방지 규칙, handoff.md 패턴 권장 |
