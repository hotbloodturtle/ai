# 의존성 맵 (Dependency Map)

> 17개 도구의 의존 관계, 분류, 설치 순서 시각화

---

## 의존성 트리 (ASCII)

```
Claude Code (01) ← 모든 도구의 기반
├── [필수] RTK (15) ← brew install rtk
│   └── jq (시스템) ← brew install jq
│
├── [필수] Superpowers (02) ← 플러그인 설치
│
├── [필수] 설정 파일 (configs)
│   ├── ~/.claude/CLAUDE.md
│   ├── ~/.claude/rules/*.md
│   ├── ~/.claude/templates/*.md
│   └── ~/.claude/settings.json
│
├── [추천] Document-Skills (05) ← anthropics/skills 마켓 등록 필요
│   └── anthropic-agent-skills 마켓플레이스
│
├── [추천] Serena ← uv (Python 패키지 도구) 필요
│   └── uv ← brew install uv
│
├── [추천] Frontend-Design ← claude-plugins-official
│
├── [추천] Context7 (08) ← Node.js
│
├── [추천] Codebase Memory (11) ← 제로 디펜던시 (단일 바이너리)
│   ├── 게이트 훅 (cbm-code-discovery-gate)
│   └── 연동 스킬 4개 (exploring, quality, reference, tracing)
│
├── [선택] gstack (12) ← Bun 필요
│   └── Bun ← curl -fsSL https://bun.sh/install | bash
│
├── [선택] Task Master (09) ← Node.js
│
├── [선택] Playwright CLI (10) ← Node.js, Chrome/Firefox/WebKit
│
├── [선택] Marketing Skills (03) ← git clone (의존성 없음)
│
├── [선택] Claude SEO (04) ← Python 3.10+ (install.sh 사용 시)
│
├── [선택] NotebookLM (06) ← Python, Google 계정
│
├── [선택] Obsidian Skills (07) ← git clone (의존성 없음)
│
├── [선택] planning-with-files (16) ← git clone (의존성 없음)
│
├── [선택] cmux (13) ← Git, bash/zsh
│
├── [선택] claude-squad (14) ← tmux, gh (GitHub CLI)
│
├── [선택] swift-lsp ← claude-plugins-official
│
└── [선택] knowledge-work-plugins (17) ← Cowork/Desktop 전용
```

---

## 3-티어 분류

### 필수 (Essential) -- 5개

| # | 도구 | 역할 | 의존성 |
|---|------|------|--------|
| 01 | Claude Code | 기본 플랫폼 | Node.js 22+ |
| 15 | RTK | 토큰 60~90% 절감 | jq |
| -- | jq | RTK 훅 스크립트 의존 | 없음 |
| 02 | Superpowers | 14개 개발 워크플로 | Claude Code |
| -- | configs | 규칙/템플릿/설정 | Claude Code |

### 추천 (Recommended) -- 5개 추가 (총 10개)

| # | 도구 | 역할 | 의존성 |
|---|------|------|--------|
| 05 | Document-Skills | 문서 작성 17개 스킬 | anthropic-agent-skills 마켓 |
| -- | Serena | 시맨틱 코드 분석 | uv |
| -- | Frontend-Design | 프론트엔드 디자인 | 없음 |
| 08 | Context7 | 최신 라이브러리 문서 | Node.js |
| 11 | Codebase Memory | 코드 지식 그래프 | 없음 (단일 바이너리) |

### 선택 (Optional) -- 7개 추가 (총 17개)

| # | 도구 | 역할 | 의존성 |
|---|------|------|--------|
| 12 | gstack | 29개 역할 가상 팀 | Bun |
| 09 | Task Master | PRD → 태스크 | Node.js |
| 10 | Playwright CLI | 브라우저 자동화 | Node.js, 브라우저 |
| 03 | Marketing Skills | 33개 마케팅 스킬 | 없음 |
| 04 | Claude SEO | 17개 SEO 스킬 | Python 3.10+ |
| 06 | NotebookLM | NotebookLM 연동 | Python, Google 계정 |
| 07 | Obsidian Skills | Obsidian 볼트 자동화 | 없음 |
| 16 | planning-with-files | 영속적 플래닝 | 없음 |
| 13 | cmux | worktree 병렬 | Git |
| 14 | claude-squad | 멀티 에이전트 | tmux, gh |
| -- | swift-lsp | Swift LSP | 없음 |
| 17 | knowledge-work-plugins | Cowork 역할별 | Cowork/Desktop |

---

## 구성별 패키지

### 최소 구성 (5개)

```
Claude Code + RTK + jq + Superpowers + configs
```

대상: 빠르게 시작하고 싶은 모든 사용자
설치 시간: 약 2분

### 추천 구성 (10개)

```
최소 구성
+ Document-Skills    (문서/스프레드시트/프레젠테이션)
+ Serena             (시맨틱 코드 분석)
+ Frontend-Design    (프론트엔드 디자인)
+ Context7           (라이브러리 최신 문서)
+ Codebase Memory    (코드 지식 그래프 + 스킬 4개)
```

대상: 웹 개발자, 풀스택 개발자
설치 시간: 약 5분

### 풀 구성 (17개)

```
추천 구성
+ gstack             (29개 역할 가상 팀)
+ Task Master        (PRD → 태스크)
+ Playwright CLI     (브라우저 자동화)
+ Marketing Skills   (33개 마케팅 스킬)
+ Claude SEO         (17개 SEO 스킬)
+ NotebookLM         (NotebookLM 연동)
+ Obsidian Skills    (Obsidian 자동화)
+ planning-with-files (영속적 플래닝)
+ cmux               (worktree 병렬)
+ claude-squad       (멀티 에이전트)
+ swift-lsp          (Swift LSP)
+ knowledge-work-plugins (Cowork 전용)
```

대상: 모든 기능을 활용하려는 파워 유저
설치 시간: 약 10분

---

## 역할별 추천 매트릭스

| 도구 | 웹개발 | 마케터 | 데이터분석 | PM |
|------|:------:|:------:|:----------:|:--:|
| Claude Code | ● | ● | ● | ● |
| RTK + jq | ● | ○ | ○ | ○ |
| Superpowers | ● | ○ | ○ | ○ |
| configs | ● | ● | ● | ● |
| Document-Skills | ● | ● | ● | ● |
| Serena | ● | | | |
| Frontend-Design | ● | ● | | |
| Context7 | ● | | ● | |
| Codebase Memory | ● | | | |
| gstack | ● | | ○ | ○ |
| Task Master | ○ | | ● | ● |
| Playwright CLI | ● | ○ | | |
| Marketing Skills | | ● | | |
| Claude SEO | ○ | ● | | |
| NotebookLM | | | ○ | ● |
| Obsidian Skills | | | | ● |
| planning-with-files | ○ | | | ● |
| cmux | ● | | | |
| claude-squad | ● | | | |
| swift-lsp | △ | | | |
| knowledge-work-plugins | | ○ | ○ | ○ |

> ● 필수 / ○ 추천 / △ Swift 개발 시만 / 빈칸 = 불필요

---

## 설치 순서 다이어그램

```
Phase 1: 기반 설치
──────────────────────────────────────────────
[1] Claude Code 설치
[2] Homebrew로 시스템 의존성 설치
    ├── jq (RTK 필수)
    ├── uv (Serena 필수)
    └── bun (gstack 선택)

Phase 2: 플러그인 설치 (settings.json 자동 생성)
──────────────────────────────────────────────
[3] anthropic-agent-skills 마켓 등록
[4] 플러그인 5개 설치
    ├── superpowers
    ├── document-skills
    ├── frontend-design
    ├── serena
    └── swift-lsp (선택)

Phase 3: MCP 서버 (settings.json에 훅 추가될 수 있음)
──────────────────────────────────────────────
[5] Context7
[6] Task Master
[7] Codebase Memory (게이트 훅 + 스킬 4개 함께 설치)

Phase 4: 스킬 설치
──────────────────────────────────────────────
[8] Playwright CLI + 스킬 등록
[9] gstack (Bun 필요) + setup
[10] 나머지 스킬 (Marketing, SEO, Obsidian, NotebookLM 등)

Phase 5: 토큰 최적화
──────────────────────────────────────────────
[11] RTK 설치 + rtk init -g
[12] 텔레메트리 비활성화

Phase 6: 병렬 도구 (선택)
──────────────────────────────────────────────
[13] cmux
[14] claude-squad

Phase 7: 최종 보정
──────────────────────────────────────────────
[15] settings.json 확인/보정
     ├── enabledPlugins 중복 제거
     ├── RTK PreToolUse 훅 추가
     ├── CBM PreToolUse 훅 확인
     └── permissions 확인
[16] 설정 파일 생성 (CLAUDE.md, rules, templates)
[17] 커스텀 스킬 10개 생성
```

---

## 시스템 의존성 요약

```
macOS 13+ (Ventura)
├── Node.js 22+ ← Claude Code, Context7, Task Master, Playwright CLI
├── Homebrew
│   ├── jq ← RTK 훅 스크립트
│   ├── rtk ← 토큰 절감
│   ├── uv ← Serena (uvx 실행)
│   ├── claude-squad ← 멀티 에이전트
│   └── python@3.12 ← Claude SEO (선택)
├── Bun ← gstack
├── Git ← cmux, 스킬 clone
├── tmux ← claude-squad
├── gh (GitHub CLI) ← claude-squad
└── Chrome/Firefox/WebKit ← Playwright CLI
```

> 참조: `claude-code-master-setup.md` 전체 / `GAP-ANALYSIS.md` 갭 상세

---

## 비용 최적화 전략

### 3단계 모델 라우팅 (하네스 엔지니어링 참고)

| 역할 | 모델 | 비중 | 용도 |
|------|------|------|------|
| 계획/설계 | Opus | 30% | 아키텍처, 복잡한 버그, 리팩토링 설계 |
| 구현 | Sonnet | 50% | 일반 코딩, 기능 구현, 테스트 작성 |
| 단순 작업 | Haiku | 20% | 코드 설명, 포맷 변환, 간단한 질문 |

→ Opus 단독 대비 **40~60% 비용 감소**

### RTK 토큰 절감
- Bash 출력 자동 압축으로 **60~90% 토큰 절감**
- 이미 PreToolUse 훅으로 설정됨

### 컨텍스트 절약 습관
- `/compact`: 대화 요약 압축
- `/clear`: 새 세션 시작
- handoff.md로 세션 간 인수인계 (컨텍스트 재사용 대신 파일 기반)
