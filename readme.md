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
| Marketing Skills | 스킬 | 40개 마케팅 전문 스킬 (SEO, CRO, 카피라이팅) | 선택 | [marketing-skills.md](marketing-skills.md) |
| Claude SEO | 스킬 | 13개 SEO 서브스킬 + 7개 서브에이전트 | 선택 | [claude-seo.md](claude-seo.md) |
| Context7 | MCP | 최신 라이브러리 문서를 컨텍스트에 주입 | 추천 | [context7.md](context7.md) |
| Task Master | MCP | PRD → 구조화된 태스크 분해 | 선택 | [task-master.md](task-master.md) |
| Playwright CLI | 스킬 | 토큰 효율적 브라우저 자동화 | 선택 | [playwright-cli.md](playwright-cli.md) |
| Codebase Memory | MCP | 코드 지식 그래프 + 게이트 훅 | 추천 | [codebase-memory.md](codebase-memory.md) |
| gstack | 스킬 | 29개 역할 가상 엔지니어링 팀 | 선택 | [gstack.md](gstack.md) |
| cmux | 병렬 도구 | Git worktree 기반 병렬 실행 | 선택 | [cmux.md](cmux.md) |
| claude-squad | 병렬 도구 | 터미널 멀티 에이전트 오케스트레이션 | 선택 | [claude-squad.md](claude-squad.md) |
| RTK | 토큰 절감 | Bash 출력 압축으로 60~90% 토큰 절감 | 필수 | [rtk.md](rtk.md) |
| planning-with-files | 스킬 | Manus 스타일 영속적 플래닝 | 선택 | [planning-with-files.md](planning-with-files.md) |
| Awesome Design MD | 디자인 레퍼런스 | 71개 사이트 DESIGN.md 컬렉션 (전역 설치) | 추천 | [awesome-design-md.md](awesome-design-md.md) |
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

### 3. 스킬 (git clone + 심링크)
각 스킬 docs의 "설치" 섹션에 검증된 명령 있음. Superpowers/Document/Marketing/Planning/BMAD/gstack/Awesome Design 모두 동일 패턴.

### 4. MCP 서버
```bash
claude mcp add --transport http --scope user context7 https://mcp.context7.com/mcp
claude mcp add --scope user task-master-ai -- npx -y task-master-ai
claude mcp add --scope user serena -- uvx --from git+https://github.com/oraios/serena serena start-mcp-server
curl -fsSL https://raw.githubusercontent.com/DeusData/codebase-memory-mcp/main/install.sh | bash
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
| `curl ... \| bash` (codebase-memory, cmux 인스톨러) | Untrusted remote code | 사용자가 터미널에서 직접 실행 |
| 외부 레포 `install.sh` 직접 실행 (claude-seo) | Untrusted external script | 사용자가 직접 실행 |
| `~/.claude/agents/`에 외부 .md 심링크 | Self-Modification (에이전트 등록) | AskUserQuestion으로 명시 승인 필요 |

각 도구 docs의 "검증된 함정" 섹션에도 명시.
