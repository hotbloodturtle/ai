# Claude Code 빠른 시작 가이드

> 전체 설치부터 첫 사용까지 10분 안에 완료

---

## 전제 조건

| 항목 | 최소 요구 | 확인 명령어 |
|------|----------|------------|
| macOS | 13+ (Ventura) | `sw_vers` |
| Node.js | 22+ | `node -v` |
| Homebrew | 최신 | `brew --version` |
| Git | 기본 설치 | `git --version` |

Node.js 미설치 시:
```bash
brew install node@22
```

---

## 1단계: 전체 설치

```bash
./setup.sh
```

설치 스크립트가 실행하는 항목 (순서대로):
1. Claude Code 설치 (`curl -fsSL https://claude.ai/install.sh | bash`)
2. Bun 설치 (gstack 의존성)
3. 마켓플레이스 등록 + 플러그인 5개 설치
4. MCP 서버 3개 추가 (Context7, Task Master, Codebase Memory)
5. Playwright CLI + 스킬 레포 클론
6. gstack, Marketing Skills, Claude SEO 등 스킬 설치
7. RTK 설치 + 훅 등록
8. 병렬 도구 (cmux, claude-squad)
9. settings.json 최종 보정

> 예상 소요 시간: 약 5~10분 (네트워크 환경에 따라 다름)

---

## 2단계: 검증

```bash
./verify.sh
```

검증 항목:
- Claude Code 실행 가능 여부
- 플러그인 5개 활성화 상태 (`claude plugin list`)
- MCP 서버 3개 연결 상태 (`claude mcp list`)
- RTK 훅 등록 여부 (`ls ~/.claude/hooks/rtk-rewrite.sh`)
- settings.json 무결성

---

## 3단계: 첫 사용

```bash
# Claude Code 실행
claude

# 또는 특정 디렉토리에서 실행
cd ~/my-project && claude
```

### 기본 명령어

| 명령어 | 설명 |
|--------|------|
| `/help` | 도움말 |
| `/plan` | 계획 모드 (실행 없이 설계만) |
| `Shift+Tab` | 계획 모드 토글 |
| `/clear` | 대화 초기화 |
| `/compact` | 컨텍스트 압축 |
| `Esc` | 현재 작업 중단 |

---

## 최소 설치

필수 도구 5개만 설치 (Claude Code + RTK + jq + Superpowers + configs):

```bash
./setup.sh --minimal
```

최소 설치 포함 항목:
- Claude Code (기본 도구)
- RTK (토큰 60~90% 절감)
- jq (RTK 훅 의존성)
- Superpowers 플러그인 (14개 개발 워크플로)
- 설정 파일 (CLAUDE.md, rules, templates)

---

## 업데이트 방법

```bash
# Claude Code 업데이트
claude update

# 플러그인 업데이트
claude plugin update superpowers
claude plugin update document-skills

# RTK 업데이트
brew upgrade rtk

# gstack 업데이트
cd ~/.claude/skills/gstack && git pull && ./setup

# MCP 서버는 npx -y로 실행되므로 자동 최신 버전 사용
```

---

## 비용 최적화 팁

### 모델 선택
- **복잡한 설계/디버깅**: `/model opus` (비싸지만 정확)
- **일반 코딩**: `/model sonnet` (기본, 균형)
- **간단한 질문**: `/model haiku` (빠르고 저렴)
- 3단계 라우팅으로 Opus 단독 대비 40~60% 비용 감소

### 토큰 절약
- RTK가 자동으로 Bash 출력 60~90% 압축 (이미 설정됨)
- `/compact`: 긴 대화 압축
- `/clear`: 새 주제 시작 시 세션 초기화
- `/cost`: 현재까지 사용 비용 확인

## 설정 동기화

여러 기기 간 Claude Code 설정을 동기화하려면:
- 이 레포를 Git으로 관리하고 `./restore-configs.sh`로 복원
- 참고: [cc-sync-template](https://github.com/jung-wan-kim/cc-sync-template) — Claude Code 설정 동기화 전용 템플릿

---

## 트러블슈팅 빠른 참조

### 1. 플러그인 설치 실패 ("Plugin not found")
```bash
# anthropic-agent-skills 마켓 등록 후 재시도
claude plugin marketplace add anthropics/skills
claude plugin install document-skills@anthropic-agent-skills
```

### 2. frontend-design 마켓 오류
```bash
# 마켓 미지정으로 자동 탐색
claude plugin install frontend-design
```

### 3. Claude SEO Python 버전 문제
```bash
# Python 3.10 미만이면 스킬 파일만 수동 복사
git clone --depth 1 https://github.com/AgriciDaniel/claude-seo.git /tmp/claude-seo
cp -R /tmp/claude-seo/skills/* ~/.claude/skills/
```

### 4. Context7 대화형 프롬프트 멈춤
```bash
# claude mcp add로 직접 추가
claude mcp add --scope user context7 -- npx -y @upstash/context7-mcp@latest
```

### 5. settings.json 중복 키
```bash
# frontend-design@claude-code-plugins 제거, claude-plugins-official만 남기기
# cat ~/.claude/settings.json 으로 확인 후 수동 보정
```

### 6. document-skills / example-skills 중복
```bash
# 동일 내용이므로 document-skills 하나만 설치
# 둘 다 설치해도 동작에 문제는 없음
```

### 7. gstack /review 이름 충돌
```bash
# 커스텀 review 스킬 이름 변경
# ~/.claude/skills/review/SKILL.md에서 name: review -> name: quick-review
```

### 8. RTK 텔레메트리 비활성화
```bash
echo 'export RTK_TELEMETRY_DISABLED=1' >> ~/.zshrc
source ~/.zshrc
```

### 9. Serena MCP 연결 실패
```bash
# uv 미설치가 원인
brew install uv
```

### 10. RTK 훅이 작동하지 않음
```bash
# rtk init -g 실행 후 settings.json에 Bash 훅 등록 확인
rtk init -g
# settings.json의 hooks.PreToolUse에 rtk-rewrite.sh 경로 확인
```

---

## 주요 슬래시 명령어 요약

### 커스텀 스킬 (한국어 특화)

| 명령어 | 설명 |
|--------|------|
| `/commit-msg` | 한국어 커밋 메시지 작성 + 커밋 |
| `/fix` | 에러 분석 → 원인 설명 → 코드 수정 |
| `/review` | 코드 검토 (버그/성능/보안) |
| `/test` | 테스트 코드 자동 생성 |
| `/explain` | 코드 한국어 해설 |
| `/refactor` | 코드 리팩토링 |
| `/translate` | 영→한 번역 |
| `/daily-report` | 일일 작업 보고서 |
| `/start-project` | 프로젝트 초기 구조 생성 |
| `/my-style` | 개인 글쓰기 스타일 적용 |

### gstack 주요 스킬

| 명령어 | 설명 |
|--------|------|
| `/office-hours` | YC 오피스아워 스타일 검토 |
| `/ship` | 테스트 → 리뷰 → PR 생성 |
| `/qa` | QA 테스트 + 버그 수정 |
| `/browse` | 브라우저 자동화 |
| `/design-review` | 디자인 리뷰 |
| `/cso` | 보안 감사 |
| `/investigate` | 체계적 디버깅 |

### Superpowers 주요 스킬

| 명령어 | 설명 |
|--------|------|
| 자동 로드 | TDD, 디버깅, 코드 리뷰 등 상황에 맞게 자동 활성화 |

---

> 상세 정보: `claude-code-master-setup.md` 참조
