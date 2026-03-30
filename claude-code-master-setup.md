# Claude Code 완전 셋업 마스터 가이드

> Claude Code에 바로 설치 가능한 Skills, MCP, 도구 17선 + 설정 현황 + 빠른 설치 가이드
>
> 최종 업데이트: 2026-03-28 (실제 설치 검증 반영)

---

## 목차

- [개념 정리](#개념-정리)
- [Part 1: Skills & MCP (01~09)](#part-1-skills--mcp)
- [Part 2: 브라우저 자동화 & 병렬 실행 (10~15)](#part-2-브라우저-자동화--병렬-실행)
- [현재 설정 현황](#현재-설정-현황)
- [빠른 설치 가이드](#빠른-설치-가이드)
- [추천 설정 조합](#추천-설정-조합)
- [PDF 가이드 추가 내용 (16~17)](#pdf-가이드-추가-내용)
- [Claude Code 내장 기능 가이드](#claude-code-내장-기능-가이드)
- [워크스페이스 템플릿](#워크스페이스-템플릿)
- [공식 플러그인 생태계](#공식-플러그인-생태계)
- [30/60/90일 도입 로드맵](#306090일-도입-로드맵)
- [스킬/플러그인 탐색 사이트](#스킬플러그인-탐색-사이트)
- [실제 설치 시 트러블슈팅](#실제-설치-시-트러블슈팅-2026-03-28-검증)

---

## 개념 정리

| 개념 | 역할 | 비유 |
|------|------|------|
| **Skill** | Claude에게 **HOW**(방법)를 가르침 | 직원 교육 매뉴얼 |
| **MCP** | Claude에게 **외부 세계 ACCESS**를 부여 | 직원에게 열쇠/권한 부여 |
| **Plugin** | Skill + MCP를 패키징하여 설치/관리 | 앱스토어 앱 |
| **Rules** | Claude의 행동 규칙 정의 | 사내 규정 |
| **Templates** | 반복 작업의 구조 템플릿 | 양식/서식 |

---

## Part 1: Skills & MCP

### 01. Anthropic Claude Code (공식)

| 항목 | 내용 |
|------|------|
| **GitHub** | [anthropics/claude-code](https://github.com/anthropics/claude-code) |
| **Stars** | 82.7k |
| **라이선스** | LICENSE.md |
| **설명** | Anthropic 공식 에이전틱 코딩 도구. 터미널에서 코드베이스를 이해하고 자연어로 작업 수행 |

**주요 기능:**
- 터미널 기반 에이전틱 코딩 (코드 이해, 생성, 수정)
- Git 워크플로 자동화
- IDE/터미널/GitHub 연동 (`@claude` 태그)
- 플러그인 시스템으로 무한 확장

**설치:**
```bash
# macOS/Linux (권장)
curl -fsSL https://claude.ai/install.sh | bash

# Homebrew
brew install --cask claude-code

# Windows
irm https://claude.ai/install.ps1 | iex

# WinGet
winget install Anthropic.ClaudeCode
```

**요구사항:** Node.js 18+

---

### 02. Superpowers

| 항목 | 내용 |
|------|------|
| **GitHub** | [obra/superpowers](https://github.com/obra/superpowers) |
| **Stars** | 113k |
| **라이선스** | MIT |
| **최신 버전** | v5.0.6 (2026-03-25) |
| **설명** | 20개+ 실전 스킬 프레임워크. TDD, 디버깅, 코드 리뷰, 병렬 에이전트 등 |

**스킬 목록 (14개):**

| 스킬 | 설명 |
|------|------|
| `brainstorming` | 코드 작성 전 소크라테스식 설계 검토 |
| `writing-plans` | 상세 구현 계획 작성 (2~5분 단위 작업) |
| `executing-plans` | 리뷰 체크포인트와 함께 계획 실행 |
| `test-driven-development` | RED → GREEN → REFACTOR 사이클 강제 |
| `systematic-debugging` | 4단계 근본 원인 분석 |
| `subagent-driven-development` | 서브에이전트에 작업 위임 + 2단계 리뷰 |
| `dispatching-parallel-agents` | 독립 태스크 병렬 처리 |
| `using-git-worktrees` | 격리된 Git Worktree에서 개발 |
| `requesting-code-review` | 서브에이전트 코드 리뷰어 디스패치 |
| `receiving-code-review` | 코드 리뷰 피드백 기술적 평가 |
| `finishing-a-development-branch` | 브랜치 완료 후 통합 옵션 안내 |
| `verification-before-completion` | 완료 주장 전 검증 명령 필수 실행 |
| `writing-skills` | 새 스킬 작성 가이드 (TDD 방식) |
| `using-superpowers` | 스킬 사용법 안내 (자동 로드) |

**설치:**
```bash
# Claude Code 공식 마켓플레이스
/plugin install superpowers@claude-plugins-official

# 사용자 마켓플레이스
/plugin marketplace add obra/superpowers-marketplace
/plugin install superpowers@superpowers-marketplace
```

---

### 03. Marketing Skills

| 항목 | 내용 |
|------|------|
| **GitHub** | [coreyhaines31/marketingskills](https://github.com/coreyhaines31/marketingskills) |
| **Stars** | 16.5k |
| **제작자** | Corey Haines |
| **설명** | 마케팅 전문 스킬 33개. CRO, 카피라이팅, SEO, 이메일 시퀀스, 그로스 해킹 |

**스킬 카테고리:**

| 카테고리 | 스킬 |
|----------|------|
| SEO & 콘텐츠 | `seo-audit`, `ai-seo`, `site-architecture`, `programmatic-seo`, `schema-markup`, `content-strategy` |
| CRO | `page-cro`, `signup-cro`, `onboarding`, `form-cro`, `popup-cro`, `paywall` |
| 카피 & 이메일 | `copywriting`, `copy-editing`, `cold-email`, `email-sequence`, `social` |
| 광고 & 측정 | `paid-ads`, `ad-creative`, `ab-test-setup`, `analytics-tracking` |
| 그로스 & 리텐션 | `referral`, `free-tool`, `churn-prevention` |
| 세일즈 & GTM | `revops`, `sales-enablement`, `launch-strategy`, `pricing-strategy`, `competitor-alternatives` |
| 전략 | `marketing-ideas`, `marketing-psychology` |
| 콘텐츠 확장 | `lead-magnets`, `social-content` |

**핵심:** `product-marketing-context` 스킬이 기반 → 다른 모든 스킬이 이를 참조하여 제품/고객/포지셔닝 이해

**설치:**
```bash
git clone https://github.com/coreyhaines31/marketingskills.git ~/.claude/skills/marketing
```

---

### 04. Claude SEO

| 항목 | 내용 |
|------|------|
| **GitHub** | [AgriciDaniel/claude-seo](https://github.com/AgriciDaniel/claude-seo) |
| **Stars** | 3.1k |
| **설명** | 종합 SEO 스킬. 13개 서브스킬, 7개 서브에이전트, DataForSEO MCP 통합 |

**서브스킬:** `audit`, `page`, `sitemap`, `schema`, `images`, `technical`, `content`, `geo`, `plan`, `programmatic`, `competitor-pages`, `hreflang` 등

**주요 기능:**
- Core Web Vitals 분석 (LCP, INP, CLS)
- E-E-A-T 분석 (2025년 9월 가이드라인 기반)
- 스키마 마크업 탐지/검증/생성 (JSON-LD, Microdata, RDFa)
- AI 검색 최적화(GEO) — Google AI Overviews, ChatGPT, Perplexity 대응
- 품질 게이트 — 30+ 페이지 경고, 50+ 강제 중단

**설치:**
```bash
# macOS/Linux (install.sh 사용 — Python 3.10+ 필요)
git clone --depth 1 https://github.com/AgriciDaniel/claude-seo.git
bash claude-seo/install.sh

# Windows (PowerShell — Python 3.10+ 필요)
git clone --depth 1 https://github.com/AgriciDaniel/claude-seo.git
powershell -ExecutionPolicy Bypass -File claude-seo\install.ps1

# ⚠️ Python 3.10 미만일 경우: 스킬 파일만 수동 복사 (DataForSEO MCP 제외)
git clone --depth 1 https://github.com/AgriciDaniel/claude-seo.git /tmp/claude-seo
cp -R /tmp/claude-seo/skills/* ~/.claude/skills/
```

> **주의:** `install.sh`는 Python 3.10+ 필수. Python 버전이 낮으면 설치 스크립트가 실패합니다.
> 수동 복사 시 17개 SEO 서브스킬은 정상 작동하지만, DataForSEO MCP 연동은 제외됩니다.

**요구사항:** Python 3.10+ (install.sh 사용 시)

**사용 예시:**
```bash
/seo audit https://example.com       # 전체 사이트 감사
/seo page https://example.com/about  # 단일 페이지 분석
/seo schema https://example.com      # 스키마 검증
/seo geo https://example.com         # AI 검색 최적화
```

---

### 05. Brand Guidelines + anthropics/skills

| 항목 | 내용 |
|------|------|
| **GitHub** | [anthropics/skills](https://github.com/anthropics/skills) (상위 저장소) |
| **Stars** | 103k (상위 저장소) |
| **설명** | 브랜드 색상/타이포그래피를 스킬로 인코딩. 모든 아티팩트에 자동 적용 |

**Anthropic 브랜드 색상:**

| 용도 | 색상명 | HEX |
|------|--------|-----|
| 기본 텍스트/어두운 배경 | Dark | `#141413` |
| 밝은 배경 | Light | `#faf9f5` |
| 보조 요소 | Mid Gray | `#b0aea5` |
| 미묘한 배경 | Light Gray | `#e8e6dc` |
| 주 강조 (액센트) | Orange | `#d97757` |
| 보조 강조 | Blue | `#6a9bcc` |
| 3차 강조 | Green | `#788c5d` |

**타이포그래피:** 제목 Poppins (대체: Arial) / 본문 Lora (대체: Georgia)

**설치:**
```bash
# 1. anthropic-agent-skills 마켓플레이스 추가 (최초 1회)
claude plugin marketplace add anthropics/skills

# 2. 플러그인 설치
claude plugin install document-skills@anthropic-agent-skills
```

> **주의:** `anthropics/skills`는 공식 마켓(`claude-plugins-official`)에 포함되어 있지 **않습니다**.
> 반드시 `claude plugin marketplace add anthropics/skills`로 마켓플레이스를 먼저 등록해야 합니다.
> `document-skills`와 `example-skills`는 **동일한 스킬 세트**입니다. 하나만 설치하면 됩니다.

**anthropics/skills 포함 스킬 전체 (17개):**
`algorithmic-art`, `brand-guidelines`, `canvas-design`, `claude-api`, `doc-coauthoring`, `docx`, `frontend-design`, `internal-comms`, `mcp-builder`, `pdf`, `pptx`, `skill-creator`, `slack-gif-creator`, `theme-factory`, `web-artifacts-builder`, `webapp-testing`, `xlsx`

---

### 06. NotebookLM Integration

| 항목 | 내용 |
|------|------|
| **GitHub** | [PleasePrompto/notebooklm-skill](https://github.com/PleasePrompto/notebooklm-skill) |
| **Stars** | 5k |
| **언어** | Python |
| **설명** | Claude Code + Google NotebookLM 연결. 업로드 문서 기반 소스 그라운딩 답변 |

**주요 기능:**
- NotebookLM과 직접 통합 (복사/붙여넣기 불필요)
- 소스 기반(Source-grounded) 응답으로 환각 대폭 감소
- 스마트 라이브러리 관리 — 태그/설명으로 노트북 저장, 자동 선택
- 1회 Google 로그인 후 세션 간 인증 유지

**설치:**
```bash
mkdir -p ~/.claude/skills
cd ~/.claude/skills
git clone https://github.com/PleasePrompto/notebooklm-skill notebooklm
```

**요구사항:** 로컬 Claude Code (웹 UI 불가), Python, Google 계정

---

### 07. Obsidian Skills

| 항목 | 내용 |
|------|------|
| **GitHub** | [kepano/obsidian-skills](https://github.com/kepano/obsidian-skills) |
| **Stars** | 17.1k |
| **라이선스** | MIT |
| **제작자** | Obsidian CEO (kepano) |
| **설명** | Obsidian용 에이전트 스킬. Markdown, Bases, JSON Canvas 사용법 + CLI 활용 |

**5가지 스킬:**
- `obsidian-markdown` — Obsidian Flavored Markdown (wikilink, callout, properties)
- `obsidian-bases` — Bases 파일 (뷰, 필터, 수식, 요약)
- `json-canvas` — JSON Canvas (노드, 에지, 그룹)
- `obsidian-cli` — CLI 기반 볼트 상호작용 + 플러그인/테마 개발
- `defuddle` — 웹 페이지 → 깨끗한 마크다운 추출 (토큰 절약)

**설치:**
```bash
# 마켓플레이스
/plugin marketplace add kepano/obsidian-skills
/plugin install obsidian@obsidian-skills

# 또는 수동
git clone --depth 1 https://github.com/kepano/obsidian-skills.git ~/.claude/skills/obsidian
```

---

### 08. Context7

| 항목 | 내용 |
|------|------|
| **GitHub** | [upstash/context7](https://github.com/upstash/context7) |
| **Stars** | 50.6k |
| **언어** | TypeScript |
| **설명** | 최신 라이브러리 문서를 LLM 컨텍스트에 주입. 환각 API 제거 |

**주요 기능:**
- 최신 버전별 라이브러리 문서 + 코드 예시 직접 주입
- 구버전 학습 데이터 의존 제거
- `resolve-library-id` — 라이브러리명 → Context7 ID 변환
- `query-docs` — 라이브러리 문서 검색
- "use context7" 한 줄이면 최신 문서 자동 참조

**설치:**
```bash
# 원클릭 설치
npx ctx7 setup

# Claude Code 전용
npx ctx7 setup --claude
```

**요구사항:** Node.js

---

### 09. Task Master

| 항목 | 내용 |
|------|------|
| **GitHub** | [eyaltoledano/claude-task-master](https://github.com/eyaltoledano/claude-task-master) |
| **Stars** | 26.2k |
| **라이선스** | MIT with Commons Clause |
| **설명** | PRD → 구조화 태스크 → AI가 하나씩 실행. 의존성 관리 포함 |

**주요 기능:**
- PRD(제품 요구사항)를 구조화된 태스크 목록으로 자동 변환
- AI 기반 태스크 분해 + 의존성 관리
- 다양한 AI 모델 지원 (Claude, GPT, Gemini, Perplexity 등)
- 리서치/메인/폴백 모델 3종 설정

**설치:**
```bash
# Claude Code (전역)
claude mcp add --scope user taskmaster-ai -- npx -y task-master-ai
```

**요구사항:** Claude Code 사용 시 별도 API 키 불필요

---

## Part 2: 브라우저 자동화 & 병렬 실행

### 10. Playwright CLI (코딩 에이전트 전용 브라우저 자동화)

| 항목 | 내용 |
|------|------|
| **GitHub** | [microsoft/playwright-cli](https://github.com/microsoft/playwright-cli) |
| **Stars** | 6.4k |
| **라이선스** | Apache-2.0 |
| **npm** | `@playwright/cli` |
| **설명** | Microsoft 공식. 코딩 에이전트(Claude Code, Copilot 등)를 위한 토큰 효율적 브라우저 자동화 CLI |

**Playwright MCP vs Playwright CLI:**

| 비교 | Playwright MCP | Playwright CLI |
|------|---------------|----------------|
| **방식** | 도구 스키마 + accessibility tree 로딩 | CLI 명령어 호출 |
| **토큰 비용** | 높음 (스키마 + 트리 전체 컨텍스트) | 낮음 (명령 결과만) |
| **설계 대상** | 범용 MCP 클라이언트 | 코딩 에이전트 특화 |
| **설치 결과** | MCP 서버 설정 | `.claude/skills/` 에 스킬 자동 등록 |

**주요 기능:**
- 브라우저 세션 관리 (headless/headed, 다중 탭)
- 페이지 탐색, 요소 상호작용, 폼 입력
- 스크린샷/PDF 캡처
- 쿠키/로컬스토리지/세션스토리지 관리
- 네트워크 목킹 및 요청 라우팅
- DevTools (콘솔, 트레이싱, 비디오 녹화)
- 스냅샷 기반 페이지 상태 확인 (ref 번호로 요소 지정)

**설치:**
```bash
# 1. 글로벌 설치
npm install -g @playwright/cli@latest

# 2. 브라우저 + 스킬 설치 (프로젝트 디렉토리에서 실행)
cd <프로젝트-디렉토리>
playwright-cli install --skills

# 3. 스킬 등록 확인
ls .claude/skills/playwright-cli/SKILL.md
```

> **중요:** `npm install -g`만으로는 스킬 디렉토리가 생성되지 않습니다.
> 반드시 프로젝트 디렉토리에서 `playwright-cli install --skills`를 실행해야
> `.claude/skills/playwright-cli/SKILL.md`가 생성되고 Claude Code가 스킬로 인식합니다.
> 새 프로젝트마다 이 단계를 반복해야 합니다.

**설치 후 생성되는 파일:**
```
.claude/skills/playwright-cli/
├── SKILL.md              # 스킬 정의 (명령어 가이드)
└── references/           # 참조 문서 7개
    ├── request-mocking.md
    ├── running-code.md
    ├── session-management.md
    ├── storage-state.md
    ├── test-generation.md
    ├── tracing.md
    └── video-recording.md
```

**사용 예시:**
```bash
# 브라우저 열기
playwright-cli open https://example.com

# 페이지 스냅샷 (요소 ref 번호 확인)
playwright-cli snapshot

# ref 번호로 요소 클릭/입력
playwright-cli click e3
playwright-cli fill e5 "user@example.com"

# 스크린샷
playwright-cli screenshot

# 쿠키 관리
playwright-cli cookie-list
playwright-cli state-save auth.json

# 닫기
playwright-cli close
```

**요구사항:** Node.js 18+, Chrome/Firefox/WebKit 중 하나

**참고:** Playwright MCP와 동시 사용 가능. MCP는 프로그래밍 방식 제어, CLI는 토큰 절약형 에이전트 작업에 각각 적합.

---

### 11. Codebase Memory MCP

| 항목 | 내용 |
|------|------|
| **GitHub** | [DeusData/codebase-memory-mcp](https://github.com/DeusData/codebase-memory-mcp) |
| **Stars** | 903 |
| **언어** | C |
| **설명** | 코드베이스 → 영구 지식 그래프(Knowledge Graph). 120배 적은 토큰 사용 |

**주요 기능:**
- Linux 커널 (28M LOC, 75K 파일) 3분 인덱싱
- 66개 언어 지원 (tree-sitter AST)
- 14개 MCP 도구 — 검색, 추적, 아키텍처 분석, Cypher 쿼리
- 10개 코딩 에이전트 지원
- 내장 3D 그래프 시각화 (localhost:9749)
- 파일 변경 자동 동기화

**설치:**
```bash
# 1. MCP 서버 설치 (macOS/Linux)
curl -fsSL https://raw.githubusercontent.com/DeusData/codebase-memory-mcp/main/install.sh | bash

# UI 포함
curl -fsSL https://raw.githubusercontent.com/DeusData/codebase-memory-mcp/main/install.sh | bash -s -- --ui

# Windows
powershell -ExecutionPolicy ByPass -c "irm https://raw.githubusercontent.com/DeusData/codebase-memory-mcp/main/install.ps1 | iex"

# 2. 설치 확인
ls ~/.claude/hooks/cbm-code-discovery-gate
ls ~/.claude/skills/codebase-memory-*/SKILL.md
```

> **중요:** 설치 스크립트가 MCP 서버뿐만 아니라 다음도 자동 생성합니다:
> - **게이트 훅** (`cbm-code-discovery-gate`): Grep/Glob/Read/Search 첫 호출을 차단하여 codebase-memory-mcp 도구 우선 사용 유도
> - **연동 스킬 4개**: codebase-memory-exploring, -quality, -reference, -tracing
> - settings.json에 PreToolUse 훅 등록이 필요합니다 (빠른 설치 Step 8 참고)

**설치 후 생성되는 파일:**
```
~/.claude/
├── hooks/cbm-code-discovery-gate   # PreToolUse 게이트 훅
└── skills/
    ├── codebase-memory-exploring/  # 코드베이스 탐색 (search_graph, get_architecture)
    ├── codebase-memory-quality/    # 코드 품질 분석 (dead code, complexity)
    ├── codebase-memory-reference/  # MCP 도구 레퍼런스 (Cypher 쿼리 가이드)
    └── codebase-memory-tracing/    # 호출 체인 추적 (trace_call_path)
```

**settings.json 훅 등록 필요:**
```json
{
  "hooks": {
    "PreToolUse": [{
      "matcher": "Grep|Glob|Read|Search",
      "hooks": [{
        "type": "command",
        "command": "~/.claude/hooks/cbm-code-discovery-gate"
      }]
    }]
  }
}
```

**요구사항:** 없음 (단일 정적 바이너리, 제로 디펜던시)

---

### 12. gstack

| 항목 | 내용 |
|------|------|
| **GitHub** | [garrytan/gstack](https://github.com/garrytan/gstack) |
| **Stars** | 47.5k |
| **라이선스** | MIT |
| **제작자** | Garry Tan (Y Combinator CEO) |
| **설명** | Claude Code를 가상 엔지니어링 팀으로. 29개 전문 스킬 (CEO, 디자이너, QA 등) |

**스프린트 단계별 스킬:**

| 단계 | 스킬 |
|------|------|
| Think | `/office-hours`, `/plan-ceo-review`, `/autoplan` |
| Plan | `/plan-eng-review`, `/plan-design-review`, `/design-consultation` |
| Build | 코드 작성 + `/browse` (브라우저 자동화), `/connect-chrome`, `/codex` |
| Review | `/review` (Staff Engineer 코드 리뷰), `/design-review` |
| Test | `/qa` (QA Lead 테스트), `/qa-only`, `/benchmark` |
| Ship | `/ship`, `/land-and-deploy`, `/canary`, `/setup-deploy`, `/document-release` |
| Guard | `/careful`, `/freeze`, `/unfreeze`, `/guard`, `/cso` (보안 감사) |
| Ops | `/investigate`, `/retro`, `/gstack-upgrade`, `/setup-browser-cookies` |

> **⚠️ 이름 충돌 주의:** gstack의 `/review`와 커스텀 스킬 `/review`가 충돌합니다.
> gstack review는 Staff Engineer 수준의 심층 코드 리뷰 (61KB), 커스텀 review는 간단한 버그/성능/보안 체크 (593B).
> 충돌을 피하려면 커스텀 `/review`를 `/quick-review` 등으로 이름을 변경하거나,
> gstack 설치 후 커스텀 review를 제거하세요.

**설치:**
```bash
# 0. Bun 설치 (미설치 시)
curl -fsSL https://bun.sh/install | bash

# 1. 글로벌 설치
git clone https://github.com/garrytan/gstack.git ~/.claude/skills/gstack
cd ~/.claude/skills/gstack && ./setup

# 2. 설치 확인 (심링크 26개 생성 여부)
ls -la ~/.claude/skills/ | grep "gstack/"

# 프로젝트별 (선택)
cp -Rf ~/.claude/skills/gstack .claude/skills/gstack
rm -rf .claude/skills/gstack/.git
cd .claude/skills/gstack && ./setup
```

> **`./setup`이 하는 일:** Bun으로 의존성 설치 후, gstack 내 28개 스킬을 `~/.claude/skills/`에 심링크로 등록합니다.
> 이를 통해 `/browse`, `/qa`, `/ship`, `/office-hours` 등을 슬래시 명령어로 바로 사용할 수 있습니다.

**요구사항:** Claude Code, Git, Bun v1.0+

---

### 13. cmux

| 항목 | 내용 |
|------|------|
| **GitHub** | [craigsc/cmux](https://github.com/craigsc/cmux) |
| **Stars** | 442 |
| **라이선스** | MIT |
| **언어** | Shell 100% |
| **설명** | tmux for Claude Code. Git worktree 기반 에이전트 병렬 격리 실행 |

**핵심 명령어:**
```bash
cmux new <branch>           # 새 worktree + Claude 실행
cmux start <branch>         # 기존 worktree에서 이어서 작업
cmux ls                     # 활성 worktree 목록
cmux merge [branch] [--squash]  # 메인에 병합
cmux rm [branch | --all]    # worktree 삭제
cmux cd [branch]            # worktree로 이동
```

**설치:**
```bash
curl -fsSL https://github.com/craigsc/cmux/releases/latest/download/install.sh | sh
echo '.worktrees/' >> .gitignore
```

**요구사항:** Git, Claude CLI, bash/zsh

---

### 14. claude-squad

| 항목 | 내용 |
|------|------|
| **GitHub** | [smtg-ai/claude-squad](https://github.com/smtg-ai/claude-squad) |
| **Stars** | 6.6k |
| **라이선스** | AGPL-3.0 |
| **언어** | Go 89% |
| **설명** | 터미널 멀티 에이전트 병렬 세션 관리. Claude, Codex, Gemini, Aider 지원 |

**주요 기능:**
- 백그라운드 작업 완료 (auto-accept 모드)
- 격리된 git 워크스페이스
- 변경사항 적용 전 리뷰
- 멀티 에이전트 지원 (Claude + Codex + Gemini + Aider)
- 프로파일 기반 에이전트 전환

**설치:**
```bash
# Homebrew
brew install claude-squad
ln -s "$(brew --prefix)/bin/claude-squad" "$(brew --prefix)/bin/cs"

# 수동
curl -fsSL https://raw.githubusercontent.com/smtg-ai/claude-squad/main/install.sh | bash
```

**요구사항:** tmux, gh (GitHub CLI)

---

### 15. RTK (Rust Token Killer)

| 항목 | 내용 |
|------|------|
| **GitHub** | [rtk-ai/rtk](https://github.com/rtk-ai/rtk) |
| **Stars** | 1.9k |
| **라이선스** | MIT |
| **언어** | Rust 100% (단일 바이너리, 제로 의존성) |
| **버전** | v0.34.0 |
| **설명** | Bash 명령어 출력을 압축하여 LLM 토큰 60~90% 절감. PreToolUse 훅 기반 CLI 프록시 |

**작동 원리:**
```
Claude Code → "git status" 실행 요청
    ↓ PreToolUse 훅이 가로챔
    ↓ "rtk git status"로 투명하게 재작성
    ↓ 출력 압축 (예: 155줄 → 3줄)
    ↓ Claude는 압축 결과만 받음 (재작성 사실 모름)
```

**지원 명령어:**

| 카테고리 | 명령어 |
|----------|--------|
| Git | `git status`, `git log`, `git diff`, `git add`, `git commit`, `git push`, `git pull` |
| GitHub CLI | `gh pr list`, `gh pr view`, `gh issue list`, `gh run list` |
| 테스트 | `cargo test`, `npm test`, `vitest`, `playwright test`, `pytest`, `go test`, `rspec` |
| 린팅 | ESLint, TypeScript (`tsc`) |
| 빌드 | Next.js 등 |
| 포매터 | Prettier |

**메타 명령어 (직접 사용):**
```bash
rtk gain              # 토큰 절감 통계
rtk gain --history    # 명령어별 절감 이력
rtk discover          # Claude Code 히스토리에서 놓친 최적화 기회 분석
rtk proxy <cmd>       # 필터링 없이 원본 출력 (디버깅용)
```

**설치:**
```bash
# 1. 바이너리 설치 (Homebrew 권장)
brew install rtk

# 또는 설치 스크립트
curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh

# 2. 글로벌 훅 설치 (hooks/rtk-rewrite.sh + RTK.md 생성)
rtk init -g

# 3. 훅 등록 확인
ls ~/.claude/hooks/rtk-rewrite.sh
cat ~/.claude/RTK.md | head -5
```

> **중요:** `brew install rtk`만으로는 Claude Code에 연동되지 않습니다.
> 반드시 `rtk init -g`를 실행하여 훅 스크립트와 RTK.md를 생성하고,
> settings.json에 PreToolUse 훅을 등록해야 합니다 (아래 참고).

**settings.json에 훅 등록 필요:**
```json
{
  "hooks": {
    "PreToolUse": [{
      "matcher": "Bash",
      "hooks": [{
        "type": "command",
        "command": "/Users/<사용자명>/.claude/hooks/rtk-rewrite.sh"
      }]
    }]
  },
  "permissions": {
    "allow": ["Bash(rtk *)"]
  }
}
```

**설치 후 생성되는 파일:**
```
~/.claude/
├── hooks/rtk-rewrite.sh    # PreToolUse 훅 스크립트
├── RTK.md                  # RTK 사용법 (CLAUDE.md에서 @RTK.md로 참조)
```

**⚠️ 보안 주의사항:**
- **텔레메트리**: 호스트명+사용자명 해시, 사용 명령어를 외부 전송 (비활성화: `RTK_TELEMETRY_DISABLED=1`)
- **로컬 DB 저장**: 명령어가 `~/.local/share/rtk/tracking.db`에 90일간 평문 저장
- **종료 코드 마스킹**: 테스트 실패 시에도 종료 코드 0 반환 가능 → Claude가 성공으로 오인할 수 있음

**제한사항:**
- Claude Code 내장 도구(Read, Grep, Glob)에는 적용 안 됨 (Bash 훅만 가로챔)
- `cargo install rtk` 사용 금지 — crates.io의 다른 패키지(Rust Type Kit)와 충돌. 반드시 `brew install rtk` 또는 `--git` 플래그 사용

**요구사항:** jq (훅 스크립트에서 사용)

---

## 현재 설정 현황

### 활성 플러그인 (6개)

| 플러그인 | 마켓플레이스 | 버전 | 스킬 수 | 비고 |
|----------|-------------|------|---------|------|
| superpowers | claude-plugins-official | 5.0.6 | 14개 | |
| document-skills | anthropic-agent-skills | 98669c11ca63 | 17개 | `anthropics/skills` 레포 기반 |
| example-skills | anthropic-agent-skills | 98669c11ca63 | 17개 | ⚠️ document-skills와 **동일 내용** — 하나만 설치해도 됨 |
| frontend-design | claude-plugins-official | latest | 1개 | ⚠️ 실제 마켓은 `claude-plugins-official` |
| serena | claude-plugins-official | latest | MCP 방식 | 스킬 파일 없음, 플러그인 내부 MCP로 동작 |
| swift-lsp | claude-plugins-official | 1.0.0 | 1개 | |

> **주의사항:**
> - `document-skills`와 `example-skills`는 내용이 완전히 동일합니다 (같은 커밋). 하나만 설치 권장.
> - `frontend-design`은 문서 초기에 `claude-code-plugins` 마켓으로 기재했으나, 해당 마켓에는 없고 `claude-plugins-official`에 존재합니다.
> - `anthropic-agent-skills` 마켓은 자동 등록되지 않으므로 `claude plugin marketplace add anthropics/skills` 필수.

### 커스텀 스킬 (10개)

| 스킬 | 명령어 | 설명 |
|------|--------|------|
| commit-msg | `/commit-msg` | 한국어 커밋 메시지 작성 |
| daily-report | `/daily-report` | 일일 작업 보고서 생성 |
| explain | `/explain` | 코드 한국어 해설 |
| fix | `/fix` | 에러 분석 → 수정 |
| my-style | `/my-style` | 개인 글쓰기 스타일 적용 |
| refactor | `/refactor` | 코드 리팩토링 |
| review | `/review` | 코드 검토 (버그/성능/보안) |
| start-project | `/start-project` | 프로젝트 초기 구조 생성 |
| test | `/test` | 테스트 코드 자동 생성 |
| translate | `/translate` | 영→한 번역 |

### 자동 인식 스킬 (1개)

| 스킬 | 인식 방식 | 설명 |
|------|----------|------|
| playwright-cli | npm 글로벌 패키지 자동 인식 | 토큰 효율적 브라우저 자동화 (에이전트 특화) |

### MCP 연동 스킬 (4개)

| 스킬 | 설명 |
|------|------|
| codebase-memory-exploring | 코드베이스 탐색 (search_graph, get_architecture) |
| codebase-memory-quality | 코드 품질 분석 (dead code, complexity) |
| codebase-memory-reference | MCP 도구 레퍼런스 (Cypher 쿼리 가이드) |
| codebase-memory-tracing | 호출 체인 추적 (trace_call_path) |

### MCP 서버

**로컬 설치 (빠른 설치 가이드로 설치되는 것):**

| 서버 | 도구 수 | 용도 | 설치 방식 |
|------|---------|------|----------|
| Context7 | 2개 | 라이브러리 최신 문서 | `claude mcp add` |
| Task Master | MCP | PRD → 태스크 관리 | `claude mcp add` |
| Codebase Memory | 14개 | 코드 지식 그래프 | `curl` 설치 스크립트 |

**claude.ai 연동 (별도 설치 불필요 — claude.ai 설정에서 활성화):**

| 서버 | 도구 수 | 용도 |
|------|---------|------|
| Slack | 12개 | 메시지/채널/캔버스 |
| Clinical Trials | 6개 | 임상시험 데이터 |

**플러그인 내장 (플러그인 설치 시 자동 포함):**

| 서버 | 도구 수 | 용도 |
|------|---------|------|
| Serena | 30+개 | 시맨틱 코드 분석 (serena 플러그인에 내장) |

> **참고:**
> - Playwright MCP는 별도 설치 필요 (`npx @anthropic-ai/mcp-server-playwright`). 이 가이드에서는 토큰 절약형 **Playwright CLI 스킬**만 설치합니다.
> - Slack, Clinical Trials는 claude.ai 계정 설정에서 MCP 연동을 활성화하면 자동으로 사용 가능합니다.
> - Sequential Thinking은 `@anthropic-ai/mcp-server-sequential-thinking`으로 별도 설치 가능하나 이 가이드에서는 다루지 않습니다.

### 규칙 & 템플릿

| 파일 | 위치 | 용도 |
|------|------|------|
| `CLAUDE.md` | `~/.claude/` | 글로벌 규칙 (한국어, 코딩 스타일, Git) |
| `frontend.md` | `~/.claude/rules/` | 프론트엔드 규칙 |
| `backend.md` | `~/.claude/rules/` | 백엔드 규칙 |
| `data-analysis.md` | `~/.claude/rules/` | 데이터 분석 규칙 |
| `presentation.md` | `~/.claude/rules/` | 발표자료 규칙 |
| `deck-template.md` | `~/.claude/templates/` | 발표자료 구조 |
| `metric-glossary.md` | `~/.claude/templates/` | 지표 용어집 |
| `review-rules.md` | `~/.claude/templates/` | 검토 체크리스트 |

### settings.json 설정

> **⚠️ 주의:** `settings.json`은 플러그인 설치 시 자동 병합됩니다.
> 아래는 **모든 설치가 끝난 후의 최종 상태**입니다.
> 플러그인 설치 전에 수동으로 이 파일을 작성하면, 설치 과정에서 키 순서가 재배치될 수 있습니다.
> **권장:** 빠른 설치 가이드 Step 1~7까지 완료 후 Step 8에서 이 파일을 확인/보정하세요.

```json
{
  "$schema": "https://json.schemastore.org/claude-code-settings.json",
  "alwaysThinkingEnabled": true,
  "effortLevel": "high",
  "enabledPlugins": {
    "document-skills@anthropic-agent-skills": true,
    "frontend-design@claude-plugins-official": true,
    "swift-lsp@claude-plugins-official": true,
    "serena@claude-plugins-official": true,
    "superpowers@claude-plugins-official": true
  },
  "extraKnownMarketplaces": {
    "anthropic-agent-skills": {
      "source": {
        "source": "github",
        "repo": "anthropics/skills"
      }
    }
  },
  "permissions": {
    "allow": [
      "Bash(npm run *)", "Bash(npx *)", "Bash(node *)",
      "Bash(python *)", "Bash(python3 *)", "Bash(pip install *)",
      "Bash(git status*)", "Bash(git log*)", "Bash(git diff*)",
      "Bash(git branch*)", "Bash(git checkout*)", "Bash(git add *)",
      "Bash(git commit*)", "Bash(git push*)", "Bash(git pull*)",
      "Bash(git stash*)", "Bash(ls *)", "Bash(cat *)", "Bash(mkdir *)",
      "Bash(gh *)", "Bash(brew *)", "Bash(curl *)",
      "Bash(pytest *)", "Bash(jest *)", "Bash(rtk *)"
    ],
    "deny": []
  },
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Grep|Glob|Read|Search",
        "hooks": [{
          "type": "command",
          "command": "~/.claude/hooks/cbm-code-discovery-gate"
        }]
      },
      {
        "matcher": "Bash",
        "hooks": [{
          "type": "command",
          "command": "/Users/<사용자명>/.claude/hooks/rtk-rewrite.sh"
        }]
      }
    ]
  }
}
```

> **이전 문서와의 차이:**
> - `frontend-design@claude-code-plugins` → `frontend-design@claude-plugins-official` (실제 마켓)
> - `example-skills` 제거 (document-skills와 동일 내용이므로 중복)
> - `extraKnownMarketplaces`: `claude-code-plugins`(존재하지 않는 마켓) 제거, `anthropic-agent-skills`(`anthropics/skills` 레포) 추가

---

## 빠른 설치 가이드

### Step 1: Claude Code 설치

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

### Step 2: 핵심 플러그인 설치

```bash
# 1. anthropic-agent-skills 마켓플레이스 등록 (최초 1회 — 이게 없으면 document-skills 설치 불가)
claude plugin marketplace add anthropics/skills

# 2. 플러그인 설치 (CLI에서 실행)
claude plugin install superpowers@claude-plugins-official     # 개발 워크플로 14개 스킬
claude plugin install document-skills@anthropic-agent-skills  # 문서 작성 17개 스킬 (pdf, xlsx, pptx 등)
claude plugin install frontend-design                         # 프론트엔드 디자인 (claude-plugins-official에서 자동 탐색)
claude plugin install serena@claude-plugins-official           # 시맨틱 코드 분석 (⚠️ uv 필요: brew install uv)
claude plugin install swift-lsp@claude-plugins-official        # Swift LSP

# 3. 설치 확인
claude plugin list
```

> **주의:**
> - `claude plugin install frontend-design`만 실행하면 `claude-plugins-official`에서 자동 탐색됩니다. 마켓 지정 불필요.
> - `example-skills`는 `document-skills`와 동일 내용이므로 설치하지 않아도 됩니다.

### Step 3: MCP 서버 추가

```bash
# Context7 (라이브러리 최신 문서)
# ⚠️ `npx ctx7 setup --claude`는 대화형 프롬프트가 뜹니다. 아래 명령으로 직접 추가 권장:
claude mcp add --scope user context7 -- npx -y @upstash/context7-mcp@latest

# Task Master (PRD → 태스크)
claude mcp add --scope user taskmaster-ai -- npx -y task-master-ai

# Codebase Memory (지식 그래프 + 게이트 훅 + 연동 스킬 4개)
curl -fsSL https://raw.githubusercontent.com/DeusData/codebase-memory-mcp/main/install.sh | bash

# Codebase Memory 설치 확인
ls ~/.claude/hooks/cbm-code-discovery-gate
ls ~/.claude/skills/codebase-memory-*/SKILL.md
```

> **주의:** Codebase Memory는 MCP 서버 외에 게이트 훅(`cbm-code-discovery-gate`)과 스킬 4개도 함께 설치됩니다.
> settings.json에 PreToolUse 훅 등록이 필요합니다 (아래 Step 8 참고).
> Codebase Memory 설치 스크립트가 settings.json을 생성할 수 있으나, CBM 훅만 포함됩니다.
> Step 8에서 RTK 훅도 함께 병합해야 합니다.

### Step 4: Playwright CLI 설치 + 스킬 등록

```bash
# 1. 글로벌 설치 (최초 1회)
npm install -g @playwright/cli@latest

# 2. 프로젝트 디렉토리에서 브라우저 + 스킬 등록 (프로젝트마다 실행)
cd <프로젝트-디렉토리>
playwright-cli install --skills

# 3. 스킬 등록 확인
ls .claude/skills/playwright-cli/SKILL.md
```

> **주의:** Step 2를 생략하면 npm 패키지만 설치되고 스킬은 등록되지 않습니다.
> 새 프로젝트를 시작할 때마다 해당 디렉토리에서 `playwright-cli install --skills`를 실행하세요.
> 기존 Playwright MCP와 별도로 작동. MCP는 도구 스키마 기반, CLI는 토큰 절약형.
> 동시 사용 가능하며 용도에 따라 선택.

### Step 5: 스킬 설치

```bash
# Bun 설치 (gstack에 필요)
curl -fsSL https://bun.sh/install | bash
source ~/.zshrc   # 또는 exec /bin/zsh

# gstack (가상 엔지니어링 팀 29개 스킬)
git clone https://github.com/garrytan/gstack.git ~/.claude/skills/gstack
cd ~/.claude/skills/gstack && ./setup

# Marketing Skills (33개)
git clone https://github.com/coreyhaines31/marketingskills.git ~/.claude/skills/marketing

# Claude SEO (17개 서브스킬)
# 방법 A: install.sh 사용 (Python 3.10+ 필요, DataForSEO MCP 포함)
git clone --depth 1 https://github.com/AgriciDaniel/claude-seo.git
bash claude-seo/install.sh

# 방법 B: Python 3.10 미만일 경우 — 스킬 파일만 수동 복사
git clone --depth 1 https://github.com/AgriciDaniel/claude-seo.git /tmp/claude-seo
cp -R /tmp/claude-seo/skills/* ~/.claude/skills/

# Obsidian Skills
git clone --depth 1 https://github.com/kepano/obsidian-skills.git ~/.claude/skills/obsidian

# NotebookLM
git clone https://github.com/PleasePrompto/notebooklm-skill ~/.claude/skills/notebooklm

# planning-with-files (Manus 스타일 영속적 플래닝)
git clone --depth 1 https://github.com/OthmanAdi/planning-with-files.git ~/.claude/skills/planning-with-files
```

> **⚠️ gstack review 이름 충돌:** gstack 설치 후 `/review`는 gstack의 Staff Engineer 리뷰를 호출합니다.
> 커스텀 스킬의 간단한 `/review`를 유지하려면, `~/.claude/skills/review/SKILL.md`의 name을 `quick-review` 등으로 변경하세요.

### Step 6: RTK 설치 + 훅 등록 (토큰 절감)

```bash
# 1. 바이너리 설치
brew install rtk

# 2. 글로벌 훅 설치 (hooks/rtk-rewrite.sh + RTK.md 자동 생성)
rtk init -g

# 3. 훅 등록 확인
ls ~/.claude/hooks/rtk-rewrite.sh

# 4. settings.json에 PreToolUse 훅 추가 (아래 Step 8 참고)

# 5. 텔레메트리 비활성화 (권장)
echo 'export RTK_TELEMETRY_DISABLED=1' >> ~/.zshrc
source ~/.zshrc
```

> **주의:** Step 2(`rtk init -g`)를 생략하면 훅 스크립트가 생성되지 않아 토큰 절감이 작동하지 않습니다.
> Step 4(settings.json 훅 등록)를 생략하면 Claude Code가 훅을 호출하지 않습니다. 두 단계 모두 필수입니다.
> Step 5(텔레메트리 비활성화)를 생략하면 호스트명+사용자명 해시와 사용 명령어가 외부 전송됩니다.

### Step 7: 병렬 실행 도구 (선택)

```bash
# cmux (Git worktree 기반 병렬)
curl -fsSL https://github.com/craigsc/cmux/releases/latest/download/install.sh | sh
echo '.worktrees/' >> .gitignore
source ~/.zshrc   # cmux는 쉘 함수로 설치됨

# claude-squad (터미널 멀티 에이전트)
brew install claude-squad
ln -s "$(brew --prefix)/bin/claude-squad" "$(brew --prefix)/bin/cs"   # 단축 명령어
```

### Step 8: settings.json 확인/보정

> Step 2 플러그인 설치 + Step 3 Codebase Memory 설치 과정에서 `settings.json`이 자동 생성/병합됩니다.
> 아래 최종 상태와 비교하여 누락된 항목(특히 RTK 훅, permissions)을 보정하세요.

```json
{
  "$schema": "https://json.schemastore.org/claude-code-settings.json",
  "alwaysThinkingEnabled": true,
  "effortLevel": "high",
  "enabledPlugins": {
    "document-skills@anthropic-agent-skills": true,
    "frontend-design@claude-plugins-official": true,
    "swift-lsp@claude-plugins-official": true,
    "serena@claude-plugins-official": true,
    "superpowers@claude-plugins-official": true
  },
  "extraKnownMarketplaces": {
    "anthropic-agent-skills": {
      "source": {
        "source": "github",
        "repo": "anthropics/skills"
      }
    }
  },
  "permissions": {
    "allow": [
      "Bash(npm run *)", "Bash(npx *)", "Bash(node *)",
      "Bash(python *)", "Bash(python3 *)", "Bash(pip install *)",
      "Bash(git status*)", "Bash(git log*)", "Bash(git diff*)",
      "Bash(git branch*)", "Bash(git checkout*)", "Bash(git add *)",
      "Bash(git commit*)", "Bash(git push*)", "Bash(git pull*)",
      "Bash(git stash*)", "Bash(ls *)", "Bash(cat *)", "Bash(mkdir *)",
      "Bash(gh *)", "Bash(brew *)", "Bash(curl *)",
      "Bash(pytest *)", "Bash(jest *)", "Bash(rtk *)"
    ],
    "deny": []
  },
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Grep|Glob|Read|Search",
        "hooks": [{
          "type": "command",
          "command": "~/.claude/hooks/cbm-code-discovery-gate"
        }]
      },
      {
        "matcher": "Bash",
        "hooks": [{
          "type": "command",
          "command": "/Users/<사용자명>/.claude/hooks/rtk-rewrite.sh"
        }]
      }
    ]
  }
}
```

> **⚠️ 실제 설치 시 자주 발생하는 문제:**
> 1. Codebase Memory 설치 스크립트가 settings.json을 생성하면서 CBM 훅만 포함 → RTK 훅이 누락됨
> 2. 플러그인 설치 시 `enabledPlugins`에 중복 키 추가됨 (예: `frontend-design@claude-code-plugins` + `frontend-design@claude-plugins-official`)
> 3. `extraKnownMarketplaces`가 플러그인 설치 과정에서 자동 추가되어 순서가 달라질 수 있음
>
> → Step 1~7 완료 후 `cat ~/.claude/settings.json`으로 확인하고, 위 내용과 비교하여 보정하세요.

> **훅 설명:**
> - `cbm-code-discovery-gate`: Codebase Memory MCP 도구 우선 사용을 유도하는 게이트 훅. Grep/Glob/Read/Search 첫 호출 시 차단하고 `search_graph`, `trace_call_path` 등을 먼저 사용하도록 안내.
> - `rtk-rewrite.sh`: Bash 명령어를 `rtk` 프록시로 투명하게 재작성하여 토큰 절감.

---

## 추천 설정 조합

### 웹 개발자

| 카테고리 | 추천 |
|----------|------|
| 필수 플러그인 | Superpowers, Document-Skills, Frontend-Design, Serena |
| MCP 서버 | Context7, Codebase Memory, Task Master |
| 브라우저 자동화 | Playwright CLI (토큰 절약) 또는 Playwright MCP (프로그래밍 제어) |
| 추가 스킬 | gstack |
| 병렬 도구 | cmux 또는 claude-squad |

### 마케터 / SEO 전문가

| 카테고리 | 추천 |
|----------|------|
| 필수 플러그인 | Document-Skills |
| 스킬 | Marketing Skills, Claude SEO, Brand Guidelines |
| MCP 서버 | Context7 |

### 데이터 분석가

| 카테고리 | 추천 |
|----------|------|
| 필수 플러그인 | Document-Skills (xlsx, pdf) |
| MCP 서버 | Context7, Task Master |
| 스킬 | gstack (`/browse` 활용) |

### PM / 기획자

| 카테고리 | 추천 |
|----------|------|
| 필수 플러그인 | Document-Skills (pptx, docx) |
| MCP 서버 | Task Master |
| 스킬 | Obsidian Skills, NotebookLM, gstack (`/office-hours`) |

---

## 전체 요약 테이블

| # | 이름 | 분류 | Stars | 핵심 가치 | 설치 검증 |
|---|------|------|-------|-----------|----------|
| 01 | Claude Code | 기본 도구 | 82.7k | Anthropic 공식 에이전틱 코딩 | ✅ |
| 02 | Superpowers | 플러그인 | 113k | 14개 개발 워크플로 스킬 | ✅ v5.0.6 |
| 03 | Marketing Skills | 스킬 | 16.5k | 33개 마케팅 전문 스킬 | ✅ |
| 04 | Claude SEO | 스킬 | 3.1k | 17개 SEO 서브스킬 | ✅ Python 3.12 + venv |
| 05 | Brand Guidelines | 플러그인 | 103k* | 브랜드 자동 적용 + 17개 공식 스킬 | ✅ document-skills로 설치 |
| 06 | NotebookLM | 스킬 | 5k | Claude + NotebookLM 연결 | ✅ |
| 07 | Obsidian Skills | 스킬 | 17.1k | Obsidian 볼트 자동화 | ✅ |
| 08 | Context7 | MCP | 50.6k | 최신 라이브러리 문서 주입 | ✅ |
| 09 | Task Master | MCP | 26.2k | PRD → 구조화 태스크 | ✅ |
| 10 | Playwright CLI | 스킬 | 6.4k | 토큰 효율적 브라우저 자동화 (에이전트 특화) | ✅ |
| 11 | Codebase Memory | MCP | 903 | 코드 지식 그래프 + 게이트 훅 + 스킬 4개 | ✅ v0.5.7 |
| 12 | gstack | 스킬 | 47.5k | 29개 역할 가상 엔지니어링 팀 | ✅ |
| 13 | cmux | 병렬도구 | 442 | Git worktree 기반 병렬 | ✅ v0.1.3 |
| 14 | claude-squad | 병렬도구 | 6.6k | 터미널 멀티 에이전트 | ✅ v1.0.17 |
| 15 | RTK | 토큰절감 | 1.9k | Bash 출력 압축 (60~90% 토큰 절감) | ✅ v0.34.0 |

> *05번 Stars는 상위 저장소(anthropics/skills) 기준

---

## 환경 복원용 파일 전체 내용

> 아래 파일들을 순서대로 생성하면 커스텀 설정이 완전 복원됩니다.
> 모든 파일은 `~/.claude/` 하위에 위치하며 **전역(Global)** 설정입니다.

### 파일 1: `~/.claude/CLAUDE.md`

```markdown
# 글로벌 규칙

## 응답 규칙
- 항상 한국어로 응답
- 전문 용어는 괄호 안에 영어 병기 (예: 커밋(Commit))
- 코드 주석은 한국어로
- 설명은 간결하게, 핵심부터

## 코딩 스타일
- 변수명은 camelCase
- 파일명은 PascalCase (컴포넌트) 또는 kebab-case (유틸)
- 함수는 짧게, 한 가지 역할만
- 타입은 TypeScript 우선

## Git 규칙
- 커밋 메시지는 한국어
- 커밋 메시지 형식: "타입: 설명" (예: "기능: 로그인 페이지 추가")
- 타입: 기능, 수정, 리팩토링, 스타일, 문서, 테스트

## 작업 방식
- 파일 수정 전 반드시 기존 코드 먼저 읽기
- 큰 변경은 단계별로 진행하고 중간 확인
- 에러 발생 시 원인 분석 후 수정 (무작정 재시도 금지)

## 세부 규칙
@rules/frontend.md
@rules/backend.md
@rules/data-analysis.md
@rules/presentation.md

## 템플릿
@templates/deck-template.md
@templates/metric-glossary.md
@templates/review-rules.md
```

---

### 파일 2: `~/.claude/rules/frontend.md`

```markdown
# 프론트엔드 규칙

## 컴포넌트
- 함수형 컴포넌트만 사용 (클래스 컴포넌트 금지)
- 컴포넌트 파일명은 PascalCase (예: UserProfile.tsx)
- 한 파일에 한 컴포넌트만
- Props 타입은 반드시 정의

## 스타일링
- CSS 변수로 색상 관리 (--primary-color 등)
- 모바일 우선 반응형 디자인
- 인라인 스타일 최소화

## 상태 관리
- 로컬 상태는 useState
- 전역 상태는 프로젝트 패턴 따르기
- 불필요한 리렌더링 방지
```

---

### 파일 3: `~/.claude/rules/backend.md`

```markdown
# 백엔드 규칙

## API
- RESTful 규칙 준수
- 에러 응답은 일관된 형식 (code, message, details)
- 입력값 검증은 컨트롤러 레벨에서

## 보안
- 환경변수로 민감정보 관리 (.env)
- SQL 인젝션 방지 (파라미터 바인딩)
- CORS 설정 명시적으로

## 데이터
- 원본 데이터 절대 수정하지 않기
- 트랜잭션 처리 필수 (여러 테이블 수정 시)
- 로그는 구조화된 형식으로
```

---

### 파일 4: `~/.claude/rules/data-analysis.md`

```markdown
# 데이터 분석 규칙

## 데이터 처리
- 원본 데이터는 data/raw/에 저장 (절대 수정하지 말 것)
- 가공된 데이터는 data/processed/에 저장
- 분석 결과는 output/에 저장
- CSV 파일 인코딩은 UTF-8

## 코딩 스타일
- 변수명은 snake_case (예: monthly_sales)
- 함수에는 docstring(설명문) 필수
- 그래프 제목과 축 라벨은 한국어
- 금액 단위는 만원으로 표시

## 분석 보고서
- 결론을 먼저 쓰고, 근거를 뒤에 나열
- 숫자에는 반드시 단위 표기
- 그래프에는 반드시 제목 포함
```

---

### 파일 5: `~/.claude/rules/presentation.md`

```markdown
# 발표자료(PPT) 규칙

## 원칙
- 분석과 발표자료 작성을 분리된 업무로 보지 않기
- 시트에서 분석 → 슬라이드로 바로 이어가는 흐름

## 슬라이드 구조
- 첫 슬라이드: 제목 + 핵심 메시지 한 줄
- 본문 슬라이드: 한 슬라이드에 핵심 메시지 하나만
- 마지막 슬라이드: 요약 + 다음 단계

## 데이터 표현
- 숫자는 반드시 단위 표기
- 그래프에는 제목, 축 라벨, 범례 필수
- 전년 대비/전월 대비 변화율 포함
- 색상으로 좋음(파랑)/나쁨(빨강) 직관적 표현

## 텍스트
- 글머리 기호는 3~5개 이내
- 한 줄에 15자 이내 권장
- 발표자 노트에 상세 설명 기록
```

---

### 파일 6: `~/.claude/templates/deck-template.md`

```markdown
# 발표자료 템플릿

## 슬라이드 구조

### 1. 표지
- 제목
- 부제목 (날짜, 발표자)

### 2. 목차
- 주요 섹션 3~5개

### 3. 핵심 요약 (Executive Summary)
- 결론 먼저
- 핵심 숫자 3개 이내
- "그래서 뭘 해야 하는가" 한 줄

### 4~N. 본문 슬라이드
- 각 슬라이드 = 하나의 메시지
- 구조: 제목(주장) → 근거(데이터/차트) → 시사점
- 차트가 있으면 "이 차트에서 봐야 할 포인트" 명시

### N+1. 다음 단계 (Next Steps)
- 구체적 액션 아이템
- 담당자, 기한 포함

### N+2. 부록 (필요 시)
- 상세 데이터
- 방법론 설명

## 디자인 가이드
- 배경: 깔끔한 단색 또는 그라데이션
- 폰트: 제목 24pt 이상, 본문 18pt 이상
- 색상: 메인 1색 + 강조 1색 + 회색 계열
- 여백 충분히
```

---

### 파일 7: `~/.claude/templates/metric-glossary.md`

```markdown
# 지표 용어집 (Metric Glossary)

## 사용법
프로젝트별로 이 파일을 복사하여 실제 지표를 채워 넣으세요.
Claude가 이 파일을 읽으면 숫자의 의미를 정확히 이해합니다.

## 매출 지표
| 지표명 | 영문 | 정의 | 단위 | 계산 방법 |
|---|---|---|---|---|
| 매출액 | Revenue | 총 판매 금액 | 만원 | 판매수량 × 단가 |
| 영업이익 | Operating Profit | 매출 - 영업비용 | 만원 | 매출액 - 매출원가 - 판관비 |
| 영업이익률 | OPM | 매출 대비 영업이익 비율 | % | 영업이익 / 매출액 × 100 |

## 성장 지표
| 지표명 | 영문 | 정의 | 단위 | 계산 방법 |
|---|---|---|---|---|
| YoY | Year over Year | 전년 동기 대비 성장률 | % | (올해 - 작년) / 작년 × 100 |
| MoM | Month over Month | 전월 대비 성장률 | % | (이번달 - 저번달) / 저번달 × 100 |
| QoQ | Quarter over Quarter | 전분기 대비 성장률 | % | (이번분기 - 저번분기) / 저번분기 × 100 |

## 사용자 지표
| 지표명 | 영문 | 정의 | 단위 | 계산 방법 |
|---|---|---|---|---|
| MAU | Monthly Active Users | 월간 활성 사용자 | 명 | 월 1회 이상 접속한 고유 사용자 |
| DAU | Daily Active Users | 일간 활성 사용자 | 명 | 일 1회 이상 접속한 고유 사용자 |
| 전환율 | Conversion Rate | 목표 행동 완료 비율 | % | 전환 수 / 방문 수 × 100 |
| 이탈률 | Churn Rate | 서비스 떠난 비율 | % | 이탈 사용자 / 전체 사용자 × 100 |

## 프로젝트별 커스텀 지표
| 지표명 | 정의 | 단위 | 비고 |
|---|---|---|---|
| | | | |
```

---

### 파일 8: `~/.claude/templates/review-rules.md`

```markdown
# 검토 규칙 (Review Rules)

## 발표자료 검토 체크리스트

### 필수 확인 (사람이 반드시 검토)
- [ ] 핵심 숫자가 원본 데이터와 일치하는가
- [ ] 대외비/민감 정보가 포함되어 있지 않은가
- [ ] 대상 청중에 맞는 수준인가
- [ ] 결론과 근거가 논리적으로 연결되는가

### Claude가 자동 검토 가능
- [ ] 오탈자 및 맞춤법
- [ ] 숫자 단위 표기 일관성
- [ ] 슬라이드 간 흐름 (논리적 순서)
- [ ] 그래프 제목/라벨 누락
- [ ] 글머리 기호 개수 (5개 이하)

### 코드 검토 체크리스트

### 필수 확인
- [ ] 기존 기능이 깨지지 않았는가
- [ ] 보안 취약점은 없는가
- [ ] 환경변수/비밀키가 노출되지 않았는가

### Claude가 자동 검토 가능
- [ ] 코딩 스타일 일관성
- [ ] 불필요한 코드/주석
- [ ] 타입 안전성
- [ ] 에러 처리 누락
```

---

### 커스텀 스킬 10개 (각각 `~/.claude/skills/<이름>/SKILL.md`)

#### 스킬 1: `commit-msg`

```markdown
---
name: commit-msg
description: 변경사항을 분석하여 한국어 커밋 메시지를 작성하고 커밋합니다
---

현재 변경사항을 분석하고 커밋해주세요.
$ARGUMENTS

작업 순서:
1. git status와 git diff로 변경 내용 확인
2. 변경 내용을 분석하여 적절한 커밋 메시지 작성
3. 커밋 메시지 형식:
   - 첫 줄: "타입: 핵심 설명" (50자 이내)
   - 빈 줄
   - 상세 설명 (필요한 경우만)
   - 타입: 기능, 수정, 리팩토링, 스타일, 문서, 테스트, 설정
4. 메시지를 보여주고 사용자 확인 후 커밋
5. 관련 파일끼리 묶어서 커밋 (한번에 다 넣지 않기)
```

#### 스킬 2: `daily-report`

```markdown
---
name: daily-report
description: 오늘 작업한 내용을 일일 보고서 형식으로 정리합니다
---

오늘 작업 내용을 보고서로 정리해주세요.
$ARGUMENTS

작업 순서:
1. git log로 오늘 커밋 내역 확인
2. 변경된 파일들 분석
3. 다음 형식으로 보고서 작성:

## 일일 작업 보고서 - [오늘 날짜]

### 완료한 작업
- (커밋 기반으로 정리)

### 변경된 파일
- (파일 목록과 변경 요약)

### 내일 할 일
- (미완료 TODO나 다음 단계 제안)

### 이슈/참고사항
- (발견된 문제나 주의사항)
```

#### 스킬 3: `explain`

```markdown
---
name: explain
description: 코드를 한국어로 줄줄이 쉽게 해설합니다
---

다음 코드를 설명해주세요:
$ARGUMENTS

설명 규칙:
- 전체 구조를 먼저 한 문장으로 요약
- 그 다음 핵심 부분을 블록별로 나눠서 설명
- 전문 용어가 나오면 괄호 안에 쉬운 설명 추가
- 비유를 적극 활용 (일상생활 소재)
- "이 코드가 왜 이렇게 작성됐는지" 의도도 설명
- 초보자가 읽어도 이해할 수 있는 수준으로
```

#### 스킬 4: `fix`

```markdown
---
name: fix
description: 에러 메시지를 분석하고 원인을 설명한 뒤 코드를 수정합니다
---

다음 에러를 해결해주세요:
$ARGUMENTS

작업 순서:
1. 에러 메시지를 한국어로 쉽게 설명 (비유를 들어서 초보자도 이해할 수 있게)
2. 원인이 되는 코드를 찾기 (Grep, Read 도구 활용)
3. 코드 수정
4. 같은 에러가 다시 나지 않도록 예방법 안내
5. 수정 후 테스트가 있다면 실행하여 검증
```

#### 스킬 5: `my-style`

```markdown
---
name: my-style
description: 사용자의 개인 글쓰기 스타일로 글을 작성합니다
---

다음 주제로 글을 써주세요: $ARGUMENTS

말투 규칙:
- 해요체 사용
- 문장은 짧게 (20자 이내 권장)
- 어려운 용어는 괄호 안에 쉬운 말로 풀이
- 비유를 자주 사용 (일상생활 소재)
- 문단은 3~4줄 이내
- 독자에게 말 거는 듯한 톤
- 핵심을 먼저 말하고, 부연 설명은 뒤에
- 불필요한 수식어 제거
```

#### 스킬 6: `refactor`

```markdown
---
name: refactor
description: 코드를 더 깔끔하고 효율적으로 리팩토링합니다
---

다음 코드를 리팩토링해주세요:
$ARGUMENTS

리팩토링 규칙:
1. 먼저 현재 코드를 읽고 구조 파악
2. 리팩토링 계획을 먼저 보여주고 확인받기
3. 기존 기능은 100% 유지 (동작이 바뀌면 안 됨)
4. 변경 사항:
   - 중복 코드 제거
   - 함수/변수 이름 명확하게
   - 긴 함수는 작은 단위로 분리
   - 불필요한 복잡성 제거
   - 타입 안전성 강화
5. 변경 전/후 비교 설명
6. 테스트가 있다면 실행하여 기능 유지 확인
7. 외부 라이브러리 추가 없이 진행
```

#### 스킬 7: `review`

```markdown
---
name: review
description: 코드를 검토하여 버그, 성능, 보안 문제를 찾아줍니다
---

다음 코드를 검토해주세요:
$ARGUMENTS

검토 항목:
- 버그(오류)와 논리적 실수
- 성능 문제 (느려지는 원인)
- 보안 취약점 (해킹 위험)
- 코딩 스타일 위반
- 가독성 개선 포인트

규칙:
- 문제를 발견하면 초보자도 이해할 수 있게 한국어로 설명
- 왜 문제인지, 어떻게 고치는지 함께 알려줄 것
- 심각도를 표시할 것 (높음/중간/낮음)
- 문제 없는 부분은 굳이 언급하지 않기
```

#### 스킬 8: `start-project`

```markdown
---
name: start-project
description: 새 프로젝트의 폴더 구조와 기본 설정을 생성합니다
---

다음 이름으로 새 프로젝트를 시작해주세요: $ARGUMENTS

작업 순서:
1. 프로젝트 목적을 확인 (사용자에게 질문)
2. 적합한 기술 스택 제안
3. 폴더 구조를 먼저 보여주고 확인받기
4. 확인 후 파일 생성:
   - 기본 폴더 구조
   - README.md (한국어)
   - .gitignore (적절한 제외 목록)
   - 기본 설정 파일 (package.json 등)
   - .claude/CLAUDE.md (프로젝트 규칙)
5. git init 및 첫 커밋
6. 다음 작업 순서 안내
```

#### 스킬 9: `test`

```markdown
---
name: test
description: 현재 파일 또는 함수에 대한 테스트 코드를 자동 생성합니다
---

다음에 대한 테스트 코드를 작성해주세요:
$ARGUMENTS

작업 순서:
1. 대상 코드를 읽고 기능 파악
2. 프로젝트의 기존 테스트 패턴 확인 (있다면 따르기)
3. 테스트 작성:
   - 정상 동작 케이스 (happy path)
   - 엣지 케이스 (빈 값, null, 경계값)
   - 에러 케이스 (잘못된 입력)
4. 테스트 파일 생성
5. 테스트 실행하여 통과 확인
6. 커버리지가 부족한 부분 안내

테스트 규칙:
- 프로젝트에 이미 있는 테스트 프레임워크 사용
- 없다면 Jest(JS/TS) 또는 pytest(Python) 기본 사용
- 테스트 이름은 한국어로 작성 (예: "빈 문자열이면 에러를 던진다")
- 각 테스트는 독립적으로 실행 가능해야 함
```

#### 스킬 10: `translate`

```markdown
---
name: translate
description: 영어 에러 메시지, 문서, 코드 주석을 한국어로 번역합니다
---

다음을 한국어로 번역해주세요:
$ARGUMENTS

번역 규칙:
- 기술 용어는 한국어(영어) 형태로 병기
- 에러 메시지는 번역 + 원인 설명 + 해결법까지
- 문서 번역은 자연스러운 한국어로 (직역 금지)
- 코드 주석은 간결하게
- 문맥을 고려한 의역 우선
```

---

### 파일 생성 자동화 스크립트

위 파일들을 한 번에 생성하려면 아래 스크립트를 실행하세요:

```bash
# 1. 디렉토리 생성
mkdir -p ~/.claude/rules
mkdir -p ~/.claude/templates
mkdir -p ~/.claude/skills/{commit-msg,daily-report,explain,fix,my-style,refactor,review,start-project,test,translate}

# 2. 이 문서에서 각 파일 내용을 복사하여 해당 경로에 저장
# 예시:
# cat > ~/.claude/CLAUDE.md << 'EOF'
# (위 CLAUDE.md 내용 붙여넣기)
# EOF

# 3. settings.json은 빠른 설치 가이드 Step 8의 내용으로 생성
# ⚠️ 주의: settings.json은 Step 2(플러그인 설치)와 Step 3(Codebase Memory 설치) 이후에 확인/보정하세요.
#    이 두 단계에서 자동 병합이 발생하므로, 먼저 수동 작성하면 덮어쓰기 충돌이 생길 수 있습니다.
#    권장 순서: Step 1~7 완료 → cat ~/.claude/settings.json 확인 → 누락 항목 보정
```

---

## PDF 가이드 추가 내용

> 출처: `claude-master-guide.pdf` (321p) + `클로드코드_완전정복_v4.pdf` (249p)

### 16. planning-with-files

| 항목 | 내용 |
|------|------|
| **GitHub** | [OthmanAdi/planning-with-files](https://github.com/OthmanAdi/planning-with-files) |
| **Stars** | 17k |
| **Forks** | 2k |
| **설명** | Manus 스타일 영속적 마크다운 플래닝 스킬. plan 파일로 계획 → handoff로 세션 이어받기 |

**주요 기능:**
- `plan.md` 기반 체크리스트 관리 (acceptance criteria, rollback 포함)
- 멀티 세션 간 `handoff.md`로 작업 이어받기
- PR review, 진행 추적, 밀리터리 체크리스트 패턴
- spec-first 표현을 포함한 구조화된 계획 수립

**설치:**
```bash
git clone --depth 1 https://github.com/OthmanAdi/planning-with-files.git ~/.claude/skills/planning-with-files
```

---

### 17. anthropics/knowledge-work-plugins (Cowork 플러그인)

| 항목 | 내용 |
|------|------|
| **GitHub** | [anthropics/knowledge-work-plugins](https://github.com/anthropics/knowledge-work-plugins) |
| **Stars** | 10k |
| **Forks** | 1k |
| **설명** | Claude Cowork(Desktop) 전용 공식 플러그인. 세일즈, 재무, 법무, 마케팅, HR, 엔지니어링 등 역할별 플러그인 |

**포함 플러그인:** Sales, Finance, Legal, Marketing, HR, Engineering Design, Operations, Data Analysis, Plugin Creation 등 11개+

**특징:**
- Cowork paid plan 또는 Claude Desktop 전용
- `organization-managed plugin` 형태로 팀 전체 배포 가능
- skills, connectors, sub-agents를 한 번에 묶어 역할 패키지로 제공

**설치:** Claude Desktop/Cowork에서 마켓플레이스를 통해 설치

---

## Claude Code 내장 기능 가이드

> 별도 설치 없이 사용 가능한 Claude Code 핵심 기능들

### Plan Mode (계획 우선 모드)

탐색과 실행을 먼저 하고 싶을 때 도움이 되는 모드.

```
/plan          # 계획 모드 진입 — 실행 없이 설계만
Shift+Tab      # 계획 모드 토글 (키보드)
```

**활용:** 복잡한 태스크에서 코드 작성 전 구조 잡기. `plan.md` 파일로 계획 저장 가능.

---

### Hooks (자동 개입 규칙)

특정 이벤트 발생 시 자동 스크립트 실행. `settings.json`에서 설정.

| Hook 타입 | 시점 | 용도 |
|-----------|------|------|
| `PreToolUse` | 도구 실행 전 | 위험 명령 차단, 린트 실행 |
| `PostToolUse` | 도구 실행 후 | 자동 포맷팅, 로그 기록 |

**설정 예시:**
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit",
        "hooks": [
          {
            "type": "command",
            "command": "pnpm lint"
          }
        ]
      }
    ]
  }
}
```

---

### Remote Control (원격 이어받기)

이미 열린 세션을 원격에서 이어받는 기능. 새 작업 만들기보다, 기존 대화의 진행을 추적하고 이어서 지시.

- 모바일/웹에서 실행 중인 세션 확인 가능
- 현재 VM에서 새 작업 띄우기도 가능 → `Claude Code on the web` 참고

---

### Channels (외부 이벤트 통로)

외부 이벤트를 Claude 세션으로 라우팅하는 경로.

| 유형 | 설명 | 예시 |
|------|------|------|
| Push | 시스템이 직접 알림 | CI alerts, Slack triggers |
| Polling | Claude가 주기적 확인 | GitHub webhooks, queue 모니터 |

---

### Scheduled Tasks (예약 실행 작업)

정해진 시간이나 반복 주기로 프롬프트 또는 `/loop`로 실행.

```bash
/loop 5m /qa          # 5분마다 QA 실행
/loop 10m /review     # 10분마다 리뷰 반복
```

- Cowork에서는 데스크톱 앱이 열려 있고 인터넷이 연결되어 있어야 작동
- Claude Code의 `scheduled task`와 Cowork의 `scheduled task`는 별도 스코프

---

### Subagents & Agent Teams (보조 에이전트)

| 개념 | 설명 |
|------|------|
| **Subagent** | 메인 세션이 특정 작업을 위임하는 독립 컨텍스트 보조 |
| **Agent Team** | 여러 에이전트가 역할 분담 (planner, builder, reviewer 등) |

**Agent Team 패턴:**
```
planner: plan.md에 범위, acceptance criteria, 취향 포인트 작성
builder: 승인된 변환만 구현하고 implementation-notes.md 갱신
reviewer: review-findings.md에 correctness, regression risk 확인
```

**관련 파일:**
- `plan.md` — 작업 체크리스트 + acceptance criteria
- `decision-log.md` — 결정 로그
- `handoff.md` — 다음 세션 인수인계
- `review-findings.md` — 리뷰 결과

---

### Worktrees (격리 작업 공간)

Git worktree로 여러 작업 브랜치를 동시에 독립 실행.

```bash
# Claude Code 내장
/worktree enter <branch>   # worktree 진입
/worktree exit             # worktree 나가기
```

- tmux와 결합하면 여러 세션을 백그라운드로 돌릴 수 있음
- `cmux`, `claude-squad`와 함께 사용 시 극대화

---

## 워크스페이스 템플릿

> PDF에서 추출한 역할별 최소 파일 세트

### Cowork 시작 템플릿

```
CLAUDE-COWORK/
├── ABOUT-ME/
│   ├── about-me.md              # 이름, 역할, 집중 과제, 좋아/싫어하는 표현
│   └── working-rules.md         # 예비리뷰 먼저, 파일 수정 전 승인 등
├── PROJECTS/
│   └── weekly-brief/
│       └── brief.md             # 목표, 대상, 성공 기준
├── TEMPLATES/
│   └── weekly-brief-template.md # 재사용 양식
└── CLAUDE-OUTPUTS/              # 산출물 저장
```

### Claude Code 최소 설정

```
프로젝트/
├── CLAUDE.md                    # 프로젝트 계약서
├── .claude/
│   ├── settings.local.json      # 프로젝트별 권한
│   └── rules/
│       └── testing.md           # 경로별 규칙
├── plan.md                      # 작업 계획 + 체크리스트
└── handoff.md                   # 세션 인수인계
```

**CLAUDE.md 최소 구조:**
```markdown
# Project Contract

## Commands
- install:
- dev:
- test:
- lint:
- build:

## Boundaries
- api:
- domain:
- ui:

## Safety
- never edit:
- always run:
- ask before:

## Verification
- unit:
- integration:
- visual:
```

### 역할별 최소 파일 세트

| 상황 | 필요 파일 |
|------|----------|
| 브리프/리서치 | `brief.md`, `working-rules.md`, `template.md` |
| PRD/기획 | `meeting-notes.md`, `open-questions.md`, `prd-template.md` |
| 버그 수정 | `CLAUDE.md`, `plan.md`, `handoff.md` |
| 논문/분석 | `claim-table.md`, `reproduction-plan.md`, `run-log.md` |
| 에이전트 팀 | `plan.md`, `decision-log.md`, `review-findings.md` |
| 콘텐츠/마케팅 | `brand-voice.md`, `anti-ai-writing-style.md`, `campaign-brief.md` |

---

## 공식 플러그인 생태계

> Anthropic 공식 마켓플레이스에서 설치 가능한 플러그인들

### 설치 우선순위 (PDF 권장 순서)

```
1. review / test / lint를 안켜하는 plugin (code-review 등)
2. skill-creator나 hookify 같은 메타 plugin
3. 주력 언어 LSP 1개 (swift-lsp, typescript-lsp 등)
4. 그 다음에야 추가 plugin 검토
```

### 주요 공식 플러그인

| 플러그인 | 설명 | 마켓플레이스 |
|----------|------|-------------|
| `code-review` | 자동 코드 리뷰 + PR 리뷰 | claude-plugins-official |
| `code-simplifier` | 코드 단순화/리팩토링 | claude-plugins-official |
| `pr-review-toolkit` | PR 검토 도구 묶음 | claude-plugins-official |
| `hookify` | Hook 생성 도구 → 자동화 규칙 쉽게 만들기 | claude-plugins-official |
| `skill-creator` | 새 스킬 작성 가이드 | anthropic-agent-skills |
| `plugin-dev` | 플러그인 개발 도구 | claude-plugins-official |
| `mcp-server-dev` | MCP 서버 개발 도구 | claude-plugins-official |
| `agent-sdk-dev` | Agent SDK 개발 도구 | claude-plugins-official |
| `commit-commands` | 커밋 관련 명령 패키지 | claude-plugins-official |

---

## 30/60/90일 도입 로드맵

> PDF 마스터 가이드 권장 도입 단계

### 0~30일: 개인 생산성 갖추기

- [ ] `CLAUDE.md` 초안 작성 (프로젝트 계약서)
- [ ] `rules/` 폴더에 경로별 규칙 추가
- [ ] `settings.json` 권한 설정 (`allow`, `deny`)
- [ ] Skill 2~3개 직접 만들어보기 (`/commit-msg`, `/review` 등)
- [ ] Context7 MCP로 라이브러리 문서 자동 참조

### 31~60일: 도구 연결 + 자동화

- [ ] MCP 추가 (Task Master, Codebase Memory 등)
- [ ] Plugin 마켓 탐색 후 필요한 것만 설치
- [ ] Hook 설정 (`PostToolUse`로 린트 자동 실행 등)
- [ ] `code-review` 플러그인으로 자동 리뷰 루프
- [ ] Skill 제작 (`skill-creator`) 또는 기존 스킬 커스터마이징

### 61~90일: 운영 체계 확립

- [ ] Remote Control로 세션 이어받기 설정
- [ ] Channels로 외부 이벤트 연결 (GitHub Actions, Slack 등)
- [ ] Scheduled Tasks로 반복 작업 자동화 (`/loop`)
- [ ] `handoff.md` 규칙 정립 (세션 간 인수인계)
- [ ] Agent Team 패턴 도입 (planner/builder/reviewer)
- [ ] 팀 거버넌스 설정 (managed settings, 승인 워크플로)

---

## 스킬/플러그인 탐색 사이트

| 사이트 | 설명 |
|--------|------|
| [agentskills.io](https://agentskills.io) | 스킬 검색/탐색 전용 사이트 |
| [skillhub (GitHub)](https://github.com/topics/claude-skills) | GitHub 기반 스킬 탐색 |
| [Awesome Claude Skills](https://github.com/travisvn/awesome-claude-skills) | 9.8k stars 큐레이션 목록 |
| [Awesome Agents](https://github.com/kyrolabs/awesome-agents) | 100+ AI 에이전트 도구 인덱스 |
| [MAGI//ARCHIVE](https://tom-doerr.github.io/repo_posts/) | 매일 업데이트 AI 레포 피드 |

---

## 전체 요약 테이블 (최종)

| # | 이름 | 분류 | Stars | 핵심 가치 |
|---|------|------|-------|-----------|
| # | 이름 | 분류 | Stars | 핵심 가치 | 설치 검증 |
|---|------|------|-------|-----------|----------|
| 01 | Claude Code | 기본 도구 | 82.7k | Anthropic 공식 에이전틱 코딩 | ✅ |
| 02 | Superpowers | 플러그인 | 113k | 14개 개발 워크플로 스킬 | ✅ v5.0.6 |
| 03 | Marketing Skills | 스킬 | 16.5k | 33개 마케팅 전문 스킬 | ✅ |
| 04 | Claude SEO | 스킬 | 3.1k | 17개 SEO 서브스킬 | ✅ Python 3.12 + venv |
| 05 | Brand Guidelines | 플러그인 | 103k* | 브랜드 자동 적용 + 17개 공식 스킬 | ✅ document-skills로 설치 |
| 06 | NotebookLM | 스킬 | 5k | Claude + NotebookLM 연결 | ✅ |
| 07 | Obsidian Skills | 스킬 | 17.1k | Obsidian 볼트 자동화 | ✅ |
| 08 | Context7 | MCP | 50.6k | 최신 라이브러리 문서 주입 | ✅ |
| 09 | Task Master | MCP | 26.2k | PRD → 구조화 태스크 | ✅ |
| 10 | Playwright CLI | 스킬 | 6.4k | 토큰 효율적 브라우저 자동화 (에이전트 특화) | ✅ |
| 11 | Codebase Memory | MCP | 903 | 코드 지식 그래프 + 게이트 훅 + 스킬 4개 | ✅ v0.5.7 |
| 12 | gstack | 스킬 | 47.5k | 29개 역할 가상 엔지니어링 팀 | ✅ |
| 13 | cmux | 병렬도구 | 442 | Git worktree 기반 병렬 | ✅ v0.1.3 |
| 14 | claude-squad | 병렬도구 | 6.6k | 터미널 멀티 에이전트 | ✅ v1.0.17 |
| 15 | RTK | 토큰절감 | 1.9k | Bash 출력 압축 (60~90% 토큰 절감) | ✅ v0.34.0 |
| 16 | planning-with-files | 스킬 | 17k | Manus 스타일 영속적 플래닝 | ✅ |
| 17 | knowledge-work-plugins | 플러그인 | 10k | Cowork 역할별 플러그인 | — (Cowork 전용) |

> *05번 Stars는 상위 저장소(anthropics/skills) 기준

---

## 실제 설치 시 트러블슈팅 (2026-03-28 검증)

> 새 macOS 환경에서 전체 설치 후 발견된 문제와 해결 방법

### 1. `document-skills` / `example-skills` 설치 실패

**증상:** `Plugin not found in any configured marketplace`

**원인:** `anthropic-agent-skills` 마켓플레이스가 기본 등록되어 있지 않음

**해결:**
```bash
claude plugin marketplace add anthropics/skills   # 마켓 등록
claude plugin install document-skills@anthropic-agent-skills   # 설치
```

### 2. `frontend-design@claude-code-plugins` 설치 실패

**증상:** `Plugin not found in marketplace "claude-code-plugins"`

**원인:** `claude-code-plugins` 마켓플레이스(`anthropics/claude-code` 레포)에는 플러그인이 없음. 실제로는 `claude-plugins-official`에 존재.

**해결:**
```bash
claude plugin install frontend-design   # 마켓 미지정 → 자동 탐색됨
```

### 3. Claude SEO `install.sh` 실패

**증상:** `Python 3.10+ is required but 3.9 was found`

**원인:** macOS 기본 Python 버전이 3.9

**해결:** 스킬 파일만 수동 복사 (DataForSEO MCP 제외)
```bash
git clone --depth 1 https://github.com/AgriciDaniel/claude-seo.git /tmp/claude-seo
cp -R /tmp/claude-seo/skills/* ~/.claude/skills/
```

### 4. Context7 `npx ctx7 setup --claude` 대화형 프롬프트

**증상:** MCP/CLI 선택 프롬프트가 뜨며 비대화형 환경에서 멈춤

**해결:** `claude mcp add`로 직접 추가
```bash
claude mcp add --scope user context7 -- npx -y @upstash/context7-mcp@latest
```

### 5. settings.json 중복 키 발생

**증상:** `enabledPlugins`에 `frontend-design@claude-code-plugins`와 `frontend-design@claude-plugins-official` 둘 다 존재

**원인:** settings.json을 수동 작성 후 `claude plugin install`이 자동 추가

**해결:** `frontend-design@claude-code-plugins` 키를 제거하고 `frontend-design@claude-plugins-official`만 남기기

### 6. `document-skills`와 `example-skills` 내용 동일

**증상:** 두 플러그인의 스킬 내용이 완전히 동일 (같은 커밋 해시)

**원인:** `anthropics/skills` 레포에서 두 이름이 같은 플러그인을 가리킴

**해결:** `document-skills` 하나만 설치하면 됩니다. 둘 다 설치해도 동작에는 문제 없음.

### 7. gstack `/review`와 커스텀 `/review` 충돌

**증상:** `/review` 입력 시 어느 것이 호출될지 예측 불가

**해결:** 커스텀 review 스킬의 이름을 변경
```bash
# ~/.claude/skills/review/SKILL.md의 name 필드를 수정
# name: review → name: quick-review
```

### 8. RTK 텔레메트리 실제 비활성화

**증상:** `rtk init -g` 후에도 텔레메트리가 활성 상태

**해결:** 환경변수를 쉘 프로필에 추가
```bash
echo 'export RTK_TELEMETRY_DISABLED=1' >> ~/.zshrc
source ~/.zshrc
```

### 9. Serena MCP 연결 실패 (`Failed to connect`)

**증상:** `claude mcp list`에서 `plugin:serena:serena: ✗ Failed to connect`

**원인:** Serena는 `uvx` 명령어로 실행되는데, `uv` (Python 패키지 실행 도구)가 미설치

**해결:**
```bash
brew install uv
# 설치 후 claude mcp list로 확인
```

### 10. Claude SEO install.sh에서 `python3`가 3.9를 가리킴

**증상:** `brew install python@3.12` 후에도 `python3 --version`이 3.9.6 (macOS 시스템 Python 우선)

**해결:** install.sh 내부의 `python3`를 `python3.12`로 치환하여 실행
```bash
sed 's/python3/python3.12/g' /tmp/claude-seo/install.sh > /tmp/claude-seo/install-312.sh
bash /tmp/claude-seo/install-312.sh
```

### 설치 순서 권장 (의존성 기준)

```
1. Claude Code 설치
2. Bun 설치 (gstack 의존)
3. 마켓플레이스 등록 + 플러그인 설치 (settings.json 자동 생성)
4. MCP 서버 추가 (Codebase Memory가 settings.json에 훅 추가)
5. Playwright CLI + 스킬 레포 클론 + gstack setup
6. RTK 설치 + rtk init -g (settings.json에 RTK 훅 수동 추가)
7. 병렬 도구 (cmux, claude-squad)
8. settings.json 최종 확인/보정
9. 설정 파일 생성 (CLAUDE.md, rules, templates, 커스텀 스킬)
```
