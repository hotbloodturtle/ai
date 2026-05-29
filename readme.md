# AI 도구 레퍼런스

AI 코딩 에이전트 생태계의 주요 도구/스킬/MCP 소개 모음

---

## 개념 정리

| 개념 | 설명 |
|------|------|
| Skill | 에이전트에게 HOW(방법)를 가르침. SKILL.md 파일로 정의. |
| MCP (Model Context Protocol) | 에이전트에게 외부 세계 접근 권한 부여. DB, API, 브라우저 등 연결. |
| Plugin | Skill + MCP를 패키징하여 마켓플레이스로 설치/관리. |
| SDK | 에이전트 능력을 프로그래밍 API로 노출. 자율 에이전트 구축용. |
| Rules | 에이전트의 행동 규칙 정의. CLAUDE.md, AGENTS.md 등. |
| Templates | 반복 작업의 구조 템플릿. |

---

## 도구 인덱스

| 이름 | 분류 | 핵심 가치 | 티어 | 파일 |
|------|------|-----------|------|------|
| Superpowers | 플러그인 | 14개 개발 워크플로 스킬 (TDD, 디버깅, 코드 리뷰 등) | 필수 | [superpowers.md](superpowers.md) |
| Document-Skills | 플러그인 | 문서 작성 17개 스킬 (pdf, xlsx, pptx, docx 등) | 추천 | [document-skills.md](document-skills.md) |
| Marketing Skills | 스킬 | 33개 마케팅 전문 스킬 (SEO, CRO, 카피라이팅) | 선택 | [marketing-skills.md](marketing-skills.md) |
| Claude SEO | 스킬 | 16개 SEO 서브스킬 + 10개 서브에이전트 | 선택 | [claude-seo.md](claude-seo.md) |
| Context7 | MCP | 최신 라이브러리 문서를 컨텍스트에 주입 | 추천 | [context7.md](context7.md) |
| Task Master | MCP | PRD → 구조화된 태스크 분해 | 선택 | [task-master.md](task-master.md) |
| Playwright CLI | 스킬 | 토큰 효율적 브라우저 자동화 | 선택 | [playwright-cli.md](playwright-cli.md) |
| Codebase Memory | MCP | 코드 지식 그래프 + 게이트 훅 | 추천 | [codebase-memory.md](codebase-memory.md) |
| Claude-Mem | 플러그인 + MCP | 세션 간 영속 메모리 (자동 압축/주입) | 추천 | [claude-mem.md](claude-mem.md) |
| gstack | 스킬 | 29개 역할 가상 엔지니어링 팀 | 선택 | [gstack.md](gstack.md) |
| cmux | 병렬 도구 | Git worktree 기반 병렬 실행 | 선택 | [cmux.md](cmux.md) |
| claude-squad | 병렬 도구 | 터미널 멀티 에이전트 오케스트레이션 | 선택 | [claude-squad.md](claude-squad.md) |
| RTK | 토큰 절감 | Bash 출력 압축으로 60~90% 토큰 절감 | 필수 | [rtk.md](rtk.md) |
| planning-with-files | 스킬 | Manus 스타일 영속적 플래닝 | 선택 | [planning-with-files.md](planning-with-files.md) |
| Awesome Design MD | 디자인 레퍼런스 | 71개 사이트 DESIGN.md 컬렉션 (로컬 클론 기준, 전역 설치) | 추천 | [awesome-design-md.md](awesome-design-md.md) |
| Serena | 플러그인 + MCP | LSP 기반 시맨틱 코드 탐색/편집 | 추천 | [serena.md](serena.md) |
| Claude Agent SDK | SDK | Claude Code 능력을 API로 노출, 자율 에이전트 구축 | 추천 | [agent-sdk.md](agent-sdk.md) |
| BMAD-METHOD | 워크플로 | 12+ 에이전트, 34+ 워크플로, 전체 SDLC 프레임워크 | 선택 | [bmad-method.md](bmad-method.md) |
| Best Practices | 실천 가이드 | Claude Code 활용 69개 팁 핵심 선별 | 추천 | [best-practices.md](best-practices.md) |

---

## 추천 조합

| 역할 | 필수 | MCP | 추가 |
|------|------|-----|------|
| 웹 개발자 | Superpowers, Document-Skills | Context7, Codebase Memory | Awesome Design MD, gstack, Playwright CLI, Agent SDK |
| 마케터/SEO | Document-Skills | Context7 | Marketing Skills, Claude SEO |
| 데이터 분석가 | Document-Skills | Context7, Task Master | gstack |
| PM/기획자 | Document-Skills | Task Master | gstack |

---

각 도구의 상세 소개와 공식 링크는 개별 파일 참조.

Android QA 자동화 → [android-qa-agent-setup.md](android-qa-agent-setup.md)

---

## 일괄 설치 가이드

처음 환경 구축 시 권장 순서. 이 프로젝트에서 검증된 시퀀스(2026-05).

### 1. 프리렉(prerequisite)
```bash
brew install node uv gh tmux           # Node/uv/gh/tmux
brew install python@3.11               # claude-seo용 (시스템 3.9 회피)
echo 'export PATH="/opt/homebrew/opt/python@3.11/libexec/bin:$PATH"' >> ~/.zshrc
curl -fsSL https://bun.sh/install | bash   # gstack용
```

### 2. CLI 도구
```bash
brew install rtk claude-squad
npm install -g @playwright/cli@latest @anthropic-ai/claude-agent-sdk
```

### 3. 스킬 (설치 경로 2가지)
- **플러그인 마켓플레이스** (이 기기의 실제 방식): Superpowers, Document-Skills/example-skills, Serena, frontend-design는 `/plugin install <이름>@<마켓플레이스>`로 설치됨. `~/.claude/plugins/cache/`에 들어가고 `~/.claude/plugins/repos/`는 **비어 있음**.
- **git clone + flat 심링크**: Marketing, planning-with-files, BMAD, gstack, Awesome Design. 각 스킬 docs의 "설치" 섹션 참고. ⚠️ Claude Code는 `~/.claude/skills/<스킬>/SKILL.md` 한 단계만 스캔하므로, 레포를 통째로 클론한 경우(예: Marketing) 각 스킬을 **최상위로 flat 심링크**해야 인식된다.

### 4. MCP 서버
```bash
# context7: HTTP 권장이나 이 기기는 stdio(npx)로 등록됨
claude mcp add --transport http --scope user context7 https://mcp.context7.com/mcp
claude mcp add --scope user task-master-ai -- npx -y task-master-ai
# serena: 이 기기는 /plugin install serena 로 설치 → plugin:serena:serena 로 등록 (아래 add는 수동 대안)
claude mcp add --scope user serena -- uvx --from git+https://github.com/oraios/serena serena start-mcp-server
curl -fsSL https://raw.githubusercontent.com/DeusData/codebase-memory-mcp/main/install.sh | bash
```

### 4-b. claude-mem (세션 간 메모리)
```bash
npx claude-mem install   # 플러그인+훅 등록
npx claude-mem start     # 워커 기동 (autostart 안 되면 수동), http://localhost:37701/health 로 확인
```

### 5. 글로벌 설정
- `~/.claude/CLAUDE.md` — Awesome Design 트리거 규칙 ([awesome-design-md.md](awesome-design-md.md) 참고)
- `~/.claude/settings.json` — Android QA permissions + RTK env

---

## 자동 분류기(auto mode) 차단 패턴

Claude Code `defaultMode: "auto"` 환경에서 다음은 사용자 직접 실행이 필요할 수 있음:

| 차단 사례 | 사유 | 우회 |
|----------|------|------|
| `~/.claude/settings.json` 편집 | Self-Modification | 사용자가 수동 편집 또는 미리 만든 JSON `cp` |
| `~/.claude/CLAUDE.md` 편집 | Self-Modification | Bash heredoc은 한 번 통과한 사례 있음 |
| `~/.zshrc` 편집 (Android SDK 환경변수 등) | Unauthorized Persistence | 사용자가 vi/nano로 직접 편집 |
| `curl ... \| bash` (codebase-memory, cmux 인스톨러) | Untrusted remote code | 사용자가 터미널에서 직접 실행 |
| 외부 레포 `install.sh` 직접 실행 (claude-seo) | Untrusted external script | 사용자가 직접 실행 |
| `npx claude-mem status/start` 등 후속 명령 | Untrusted third-party code (npx) | 사용자가 직접 실행. 단 `npx claude-mem install`은 통과한 사례 있음 |
| `~/.claude/agents/`에 외부 .md 심링크 | Self-Modification (에이전트 등록) | AskUserQuestion으로 명시 승인 필요 |

각 도구 docs의 "검증된 함정" 섹션에도 명시.

---

## 실제 설치 상태 메모 (2026-05-28 검증)

문서와 기기 상태를 대조하여 갱신함.

### 문서에 없으나 기기에 설치된 항목 (참고)
- **andrej-karpathy-skills** (`karpathy-skills` 마켓플레이스) — Karpathy 가이드라인 스킬
- **swift-lsp** (`claude-plugins-official`) — Swift LSP 플러그인
- **notebooklm**, **obsidian** — 개별 스킬 (`~/.claude/skills/`)
- 개인 한국어 스킬: explain, test, translate, my-style, start-project, review, refactor, fix, commit-msg, daily-report

### 해결된 결정 사항
- **android-qa-agent 경로**: `~/Documents/projects/android-qa-agent`로 확정. 모든 문서가 이 경로로 일관되며, android-qa 심링크(`~/.local/bin/android-qa` 등)도 이 경로를 가리키도록 재지정한다(`angie-projects` 경로는 사용하지 않음).
- **awesome-design-md 사이트 수**: 로컬 클론(이 기기 2026-05-29 재클론 기준) **71개**, 문서도 71개로 통일됨. 글로벌 `~/.claude/CLAUDE.md`에는 실제 디렉토리 수(현재 71개)를 적는다(자동 분류기 차단 시 사용자가 직접 수정). upstream은 계속 증가하므로 `git pull` 후 실제 디렉토리 수를 따른다.
