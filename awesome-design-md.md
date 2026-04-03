# Awesome Design MD

AI 에이전트를 위한 마크다운 디자인 시스템 컬렉션. 54개 유명 사이트의 디자인 토큰을 DESIGN.md 형식으로 제공.

- 공식: https://github.com/VoltAgent/awesome-design-md
- 포맷: Google Stitch DESIGN.md 표준

---

## 핵심 개념

DESIGN.md는 마크다운으로 작성된 디자인 시스템 문서.
Figma 없이도 AI 에이전트가 일관된 UI를 생성할 수 있도록 색상, 타이포그래피, 컴포넌트 스타일 등을 정의.

| 파일 | 대상 | 역할 |
|------|------|------|
| AGENTS.md | 코딩 에이전트 | 프로젝트를 어떻게 구축할 것인가 |
| DESIGN.md | 디자인 에이전트 | 프로젝트가 어떻게 보여야 할 것인가 |

---

## 설치

```bash
# 전역 설치 (한 번만)
mkdir -p ~/.claude/design-systems
git clone https://github.com/VoltAgent/awesome-design-md.git ~/.claude/design-systems/awesome-design-md
```

설치 경로: `~/.claude/design-systems/awesome-design-md/design-md/`

---

## 글로벌 CLAUDE.md 설정

`~/.claude/CLAUDE.md`에 아래 규칙 추가:

```markdown
## 디자인 시스템 (Awesome Design)

### 트리거
- "awesome design", "어썸 디자인" 키워드가 포함된 요청 시 아래 규칙 적용
- 예: "awesome design 써서 예쁘게 만들어줘", "awesome design으로 랜딩 만들어"

### 레퍼런스
- 디자인 레퍼런스 위치: ~/.claude/design-systems/awesome-design-md/design-md/
- 54개 사이트의 DESIGN.md 보유 (Claude, Vercel, Linear, Notion, Stripe 등)

### Awesome Design 요청 처리 흐름
1. 특정 스타일 지정 시 → 해당 DESIGN.md 읽고 바로 적용
2. 스타일 미지정 시 → 프로젝트 성격 파악 → 적합한 DESIGN.md 2~3개 추천 → 선택 후 적용

### DESIGN.md 활용 규칙
- UI 구현 시 프로젝트 루트의 DESIGN.md가 있으면 반드시 참조
- 색상은 시맨틱 이름으로 관리 (hex 직접 하드코딩 금지)
- Do's/Don'ts 섹션이 있으면 반드시 확인 후 구현
- 정의되지 않은 컴포넌트는 기존 토큰과 일관되게 유추

### 워크플로우
1. /design-consultation 스킬로 초기 디자인 방향 결정 (선택)
2. awesome-design-md 레퍼런스로 상세 토큰 적용
3. 프로젝트 루트에 DESIGN.md 배치 → 이후 모든 UI 작업이 참조
```

---

## 사용법

### "awesome design" 키워드로 사용

```
"awesome design 써서 예쁘게 만들어줘"          → 프로젝트에 맞는 스타일 추천
"awesome design Vercel 스타일로 랜딩 만들어"    → Vercel DESIGN.md 바로 적용
"awesome design으로 이 대시보드 디자인 입혀줘"   → 적합한 스타일 추천 후 적용
```

스타일을 지정하면 바로 적용, 안 하면 프로젝트 성격 보고 2~3개 추천.

### 특정 스타일 직접 지정

```
"Stripe 스타일로 결제 페이지 만들어"
"Linear 느낌의 이슈 트래커 만들어줘"
"Claude 디자인으로 채팅 UI 만들어"
```

### 프로젝트 전용 DESIGN.md 세팅

```
"Stripe 디자인 시스템을 이 프로젝트에 세팅해줘"
```

또는 직접 복사:
```bash
cp ~/.claude/design-systems/awesome-design-md/design-md/stripe/DESIGN.md ./DESIGN.md
```

### design-consultation 스킬과 연동

```
"/design-consultation으로 디자인 시스템 만들어줘. Notion 스타일을 참고해서."
```

- design-consultation이 디자인 방향/의사결정 수행
- awesome-design-md의 레퍼런스로 상세 토큰 보강
- 두 도구는 보완 관계 (방향 vs 구체적 값)

### 프리뷰 확인

```bash
open ~/.claude/design-systems/awesome-design-md/design-md/claude/preview.html
open ~/.claude/design-systems/awesome-design-md/design-md/claude/preview-dark.html
```

---

## DESIGN.md 9개 섹션

| # | 섹션 | 내용 |
|---|------|------|
| 1 | Visual Theme & Atmosphere | 분위기, 밀도, 디자인 철학 |
| 2 | Color Palette & Roles | 시맨틱 이름 + hex + 기능적 역할 |
| 3 | Typography Rules | 폰트, 크기, 굵기, 라인높이 테이블 |
| 4 | Component Stylings | 버튼, 카드, 인풋, 네비게이션 상태별 스타일 |
| 5 | Layout Principles | 간격 스케일, 그리드, 공백 철학 |
| 6 | Depth & Elevation | 그림자 시스템, 표면 계층 |
| 7 | Do's and Don'ts | 디자인 가드레일, 안티패턴 |
| 8 | Responsive Behavior | 브레이크포인트, 터치 타겟, 접기 전략 |
| 9 | Agent Prompt Guide | 색상 참조, 즉시 사용 가능한 프롬프트 |

---

## 포함된 54개 사이트

### AI & ML
airbnb, claude, cohere, elevenlabs, minimax, mistral.ai, ollama, opencode.ai, replicate, runwayml, together.ai, x.ai

### 개발자 도구
cursor, expo, linear.app, lovable, mintlify, posthog, raycast, resend, sentry, supabase, superhuman, vercel, warp, zapier

### 인프라 & 클라우드
clickhouse, composio, hashicorp, mongodb, sanity, stripe

### 디자인 & 생산성
airtable, cal, clay, figma, framer, intercom, miro, notion, pinterest, webflow

### 금융
coinbase, kraken, revolut, wise

### 엔터프라이즈
apple, bmw, ibm, nvidia, spacex, spotify, uber, voltagent

---

## 업데이트

```bash
cd ~/.claude/design-systems/awesome-design-md && git pull
```

---

## design-consultation 스킬과의 관계

| 항목 | design-consultation | awesome-design-md |
|------|-------------------|------------------|
| 목적 | 새 프로젝트 디자인 의사결정 | 기존 사이트 디자인 토큰 레퍼런스 |
| 출력 | 7섹션 DESIGN.md (방향 중심) | 9섹션 DESIGN.md (구체적 값) |
| 강점 | Product Context, Motion, 의사결정 로그 | Components, Do's/Don'ts, Responsive, Agent Prompt |
| 사용 시점 | 프로젝트 시작 시 디자인 방향 수립 | 구현 시 구체적 토큰 참조 |

**권장 워크플로우**: design-consultation으로 방향 잡기 → awesome-design-md 레퍼런스로 상세 값 보강
