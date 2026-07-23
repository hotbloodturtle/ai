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
| Awesome Design MD | 디자인 레퍼런스 | 유명 사이트 DESIGN.md 컬렉션 (upstream 증가 중, 전역 설치) | 추천 | [awesome-design-md.md](awesome-design-md.md) |
| Serena | 플러그인 + MCP | LSP 기반 시맨틱 코드 탐색/편집 | 추천 | [serena.md](serena.md) |
| Claude Agent SDK | SDK | Claude Code 능력을 API로 노출, 자율 에이전트 구축 | 추천 | [agent-sdk.md](agent-sdk.md) |
| BMAD-METHOD | 워크플로 | 12+ 에이전트, 34+ 워크플로, 전체 SDLC 프레임워크 | 선택 | [bmad-method.md](bmad-method.md) |
| Best Practices | 실천 가이드 | Claude Code 활용 69개 팁 핵심 선별 | 추천 | [best-practices.md](best-practices.md) |
| Ponytail | 플러그인 | 과잉 설계 억제 → 코드량·비용·시간 절감 (RTK와 상호보완) | 추천 | [ponytail.md](ponytail.md) |
| Claude HUD | 플러그인 | statusline에 컨텍스트/도구/에이전트/할일 실시간 표시 | 추천 | [claude-hud.md](claude-hud.md) |
| explain-diff | 커맨드(프롬프트) | diff/PR을 배경·직관·코드·퀴즈 인터랙티브 HTML로 설명 | 선택 | [explain-diff.md](explain-diff.md) |

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
brew install node uv gh tmux           # node는 nvm 등 버전 매니저로 관리해도 무방
# claude-seo는 Python 3.10+ 필요. install.sh가 자체 .venv를 생성하므로 3.10+ 인터프리터만 잡히면 됨.
# 3.10+가 없을 때만 아래로 확보:
brew install python@3.11
echo 'export PATH="/opt/homebrew/opt/python@3.11/libexec/bin:$PATH"' >> ~/.zshrc
curl -fsSL https://bun.sh/install | bash   # gstack용
```

### 2. CLI 도구
```bash
brew install rtk claude-squad
npm install -g @playwright/cli@latest
# Claude Agent SDK는 전역 CLI가 아니라 프로젝트별 라이브러리다 → 쓰는 프로젝트에서 `npm install @anthropic-ai/claude-agent-sdk` ([agent-sdk.md](agent-sdk.md))
```

### 3. 스킬 (설치 경로 2가지)
- **플러그인 마켓플레이스** (권장): Superpowers, Document-Skills/example-skills, Serena, frontend-design, Ponytail, Claude HUD는 `/plugin install <이름>@<마켓플레이스>`로 설치. `~/.claude/plugins/cache/`에 들어간다. git clone 방식 스킬의 원본 레포(bmad-method, claude-seo 등)는 `~/.claude/plugins/repos/`에 두는 것을 권장.
- **git clone + flat 심링크**: Marketing, planning-with-files, BMAD, gstack, Awesome Design. 각 스킬 docs의 "설치" 섹션 참고. ⚠️ Claude Code는 `~/.claude/skills/<스킬>/SKILL.md` 한 단계만 스캔하므로, 레포를 통째로 클론한 경우(예: Marketing) 각 스킬을 **최상위로 flat 심링크**해야 인식된다.

### 4. MCP 서버
```bash
# context7: HTTP 트랜스포트 권장 (stdio(npx) 방식도 동작, 차이는 첫 호출 속도뿐)
claude mcp add --transport http --scope user context7 https://mcp.context7.com/mcp
claude mcp add --scope user task-master-ai -- npx -y task-master-ai
# serena: /plugin install serena 로 설치하면 plugin:serena:serena 로 자동 등록 (아래 add는 수동 대안)
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
- `~/.claude/settings.json` — Android QA permissions(`Bash(adb *)`, `Bash(emulator *)` 등) + `env.CLAUDE_CODE_DISABLE_AUTO_MEMORY` + `env.RTK_TELEMETRY_DISABLED=1` + `statusLine`(claude-hud 래퍼, [claude-hud.md](claude-hud.md) 참고)

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

## 기기별 설치 검증 체크리스트

> 이 문서는 **여러 기기에서 공용**으로 쓴다. 특정 기기의 설치 이력·상태는 문서에 기록하지 않는다.
> 새 기기 세팅 후 또는 주기 점검 시 아래로 문서 ↔ 기기 상태를 대조한다.

| 대상 | 확인 방법 |
|------|-----------|
| CLI 도구 | `command -v rtk claude-squad playwright-cli bun node uv gh tmux` |
| 플러그인 | `~/.claude/plugins/installed_plugins.json` — superpowers, serena, document-skills/example-skills, frontend-design, claude-mem, ponytail, claude-hud 등 |
| MCP 서버 | `claude mcp list` — context7, task-master, codebase-memory (serena는 플러그인 설치 시 `plugin:serena:serena`) |
| claude-mem 워커 | `curl -s http://localhost:37701/health` |
| 스킬 | `ls ~/.claude/skills/` — flat 심링크(marketing 등)와 개인 스킬 확인 |
| 슬래시 커맨드 | `ls ~/.claude/commands/` — explain-diff 등 |
| statusLine | `~/.claude/settings.json`의 `statusLine` + `~/.claude/claude-hud-statusline.sh` 존재 |
| 디자인 레퍼런스 | `ls ~/.claude/design-systems/awesome-design-md/design-md \| wc -l` (upstream 증가 중 — 실제 수를 따른다) |
| cmux | `type cmux` (zsh 함수) 또는 `command -v cmux` |

⚠️ `~/.claude`가 백업 복원·재설치 등으로 과거 시점으로 되돌아가면 최근 설치분이 조용히 사라질 수 있다. 점검 시 위 체크리스트 전체를 돌릴 것. 개인 스킬(`~/.claude/skills/`)과 커맨드(`~/.claude/commands/`)는 레포 밖 유일 사본이 되기 쉬우니 **백업(Time Machine 등)을 유지**한다.

## 규약 (모든 기기 공통)

- **android-qa-agent 경로**: `~/Documents/projects/android-qa-agent`로 통일. 심링크(`~/.local/bin/android-qa` 등)도 이 경로를 가리킨다.
- **awesome-design-md 사이트 수**: upstream이 계속 증가하므로 문서·글로벌 `~/.claude/CLAUDE.md`에 특정 개수를 고정하지 않고, `git pull` 후 실제 디렉토리 수를 따른다.
- **statusLine**: ponytail의 statusline 배지와 claude-hud는 상호 배타적(statusLine은 하나만 가능) → claude-hud를 채택한다.
