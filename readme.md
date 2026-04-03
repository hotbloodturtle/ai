# AI 도구 레퍼런스

AI 코딩 에이전트 생태계의 주요 도구/스킬/MCP 소개 모음

---

## 개념 정리

| 개념 | 설명 |
|------|------|
| Skill | 에이전트에게 HOW(방법)를 가르침. SKILL.md 파일로 정의. |
| MCP (Model Context Protocol) | 에이전트에게 외부 세계 접근 권한 부여. DB, API, 브라우저 등 연결. |
| Plugin | Skill + MCP를 패키징하여 마켓플레이스로 설치/관리. |
| Rules | 에이전트의 행동 규칙 정의. CLAUDE.md, AGENTS.md 등. |
| Templates | 반복 작업의 구조 템플릿. |

---

## 도구 인덱스

| # | 이름 | 분류 | 핵심 가치 | 티어 | 파일 |
|---|------|------|-----------|------|------|
| 01 | Superpowers | 플러그인 | 14개 개발 워크플로 스킬 (TDD, 디버깅, 코드 리뷰 등) | 필수 | [superpowers.md](superpowers.md) |
| 02 | Document-Skills | 플러그인 | 문서 작성 17개 스킬 (pdf, xlsx, pptx, docx 등) | 추천 | [document-skills.md](document-skills.md) |
| 03 | Marketing Skills | 스킬 | 33개 마케팅 전문 스킬 (SEO, CRO, 카피라이팅) | 선택 | [marketing-skills.md](marketing-skills.md) |
| 04 | Claude SEO | 스킬 | 17개 SEO 서브스킬 + 7개 서브에이전트 | 선택 | [claude-seo.md](claude-seo.md) |
| 05 | NotebookLM | 스킬 | Google NotebookLM 연동, 소스 기반 답변 | 선택 | [notebooklm.md](notebooklm.md) |
| 06 | Obsidian Skills | 스킬 | Obsidian 볼트 자동화 (마크다운, Bases, Canvas) | 선택 | [obsidian-skills.md](obsidian-skills.md) |
| 07 | Context7 | MCP | 최신 라이브러리 문서를 컨텍스트에 주입 | 추천 | [context7.md](context7.md) |
| 08 | Task Master | MCP | PRD → 구조화된 태스크 분해 | 선택 | [task-master.md](task-master.md) |
| 09 | Playwright CLI | 스킬 | 토큰 효율적 브라우저 자동화 | 선택 | [playwright-cli.md](playwright-cli.md) |
| 10 | Codebase Memory | MCP | 코드 지식 그래프 + 게이트 훅 | 추천 | [codebase-memory.md](codebase-memory.md) |
| 11 | gstack | 스킬 | 29개 역할 가상 엔지니어링 팀 | 선택 | [gstack.md](gstack.md) |
| 12 | cmux | 병렬 도구 | Git worktree 기반 병렬 실행 | 선택 | [cmux.md](cmux.md) |
| 13 | claude-squad | 병렬 도구 | 터미널 멀티 에이전트 오케스트레이션 | 선택 | [claude-squad.md](claude-squad.md) |
| 14 | RTK | 토큰 절감 | Bash 출력 압축으로 60~90% 토큰 절감 | 필수 | [rtk.md](rtk.md) |
| 15 | planning-with-files | 스킬 | Manus 스타일 영속적 플래닝 | 선택 | [planning-with-files.md](planning-with-files.md) |
| 16 | knowledge-work-plugins | 플러그인 | Cowork/Desktop 역할별 플러그인 | 선택 | [knowledge-work-plugins.md](knowledge-work-plugins.md) |
| 17 | Awesome Design MD | 디자인 레퍼런스 | 54개 사이트 DESIGN.md 컬렉션 (전역 설치) | 추천 | [awesome-design-md.md](awesome-design-md.md) |

---

## 추천 조합

| 역할 | 필수 | MCP | 추가 |
|------|------|-----|------|
| 웹 개발자 | Superpowers, Document-Skills | Context7, Codebase Memory | Awesome Design MD, gstack, Playwright CLI |
| 마케터/SEO | Document-Skills | Context7 | Marketing Skills, Claude SEO |
| 데이터 분석가 | Document-Skills | Context7, Task Master | gstack |
| PM/기획자 | Document-Skills | Task Master | Obsidian Skills, NotebookLM |

---

각 도구의 상세 소개와 공식 링크는 개별 파일 참조.

Android QA 자동화 → [android-qa-agent-setup.md](android-qa-agent-setup.md)
