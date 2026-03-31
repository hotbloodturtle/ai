# Claude Code 설정 백업

`~/.claude/` 디렉토리의 설정 파일을 백업한 폴더입니다.

## 디렉토리 구조

```
configs/
├── CLAUDE.md                  # 글로벌 규칙 (응답, 코딩 스타일, Git, 작업 방식)
├── RTK.md                     # RTK (Rust Token Killer) 사용 가이드
├── settings.json              # Claude Code 권한, 훅, 플러그인 설정
├── settings.local.json        # 로컬 전용 설정 (MCP 서버 등)
├── rules/                     # 분야별 세부 규칙
│   ├── frontend.md            # 프론트엔드 (컴포넌트, 스타일링, 상태 관리)
│   ├── backend.md             # 백엔드 (API, 보안, 데이터)
│   ├── data-analysis.md       # 데이터 분석 (처리, 코딩 스타일, 보고서)
│   └── presentation.md        # 발표자료 (슬라이드 구조, 데이터 표현)
├── templates/                 # 재사용 템플릿
│   ├── deck-template.md       # 발표자료 슬라이드 구조 템플릿
│   ├── metric-glossary.md     # 지표 용어집 (매출, 성장, 사용자 지표)
│   └── review-rules.md        # 검토 체크리스트 (발표자료, 코드)
├── hooks/                     # Claude Code 훅 스크립트
│   └── cbm-code-discovery-gate  # codebase-memory-mcp 우선 사용 유도 훅
└── skills/                    # 커스텀 슬래시 커맨드
    ├── commit-msg/SKILL.md    # /commit-msg - 한국어 커밋 메시지 작성
    ├── daily-report/SKILL.md  # /daily-report - 일일 작업 보고서 생성
    ├── explain/SKILL.md       # /explain - 코드 한국어 해설
    ├── fix/SKILL.md           # /fix - 에러 분석 및 수정
    ├── my-style/SKILL.md      # /my-style - 개인 글쓰기 스타일 작성
    ├── refactor/SKILL.md      # /refactor - 코드 리팩토링
    ├── review/SKILL.md        # /review - 코드 검토 (버그, 성능, 보안)
    ├── start-project/SKILL.md # /start-project - 새 프로젝트 생성
    ├── test/SKILL.md          # /test - 테스트 코드 자동 생성
    └── translate/SKILL.md     # /translate - 영어→한국어 번역
```

## 복원 방법

### 전체 복원

```bash
# 기존 설정 백업 (선택)
cp -r ~/.claude ~/.claude.bak

# 파일 복사
cp configs/CLAUDE.md ~/.claude/CLAUDE.md
cp configs/RTK.md ~/.claude/RTK.md
cp configs/settings.json ~/.claude/settings.json
cp configs/settings.local.json ~/.claude/settings.local.json

# 규칙 파일 복사
cp configs/rules/*.md ~/.claude/rules/

# 템플릿 복사
cp configs/templates/*.md ~/.claude/templates/

# 훅 스크립트 복사 및 실행 권한 부여
cp configs/hooks/cbm-code-discovery-gate ~/.claude/hooks/
chmod +x ~/.claude/hooks/cbm-code-discovery-gate

# 스킬 복사
for skill in commit-msg daily-report explain fix my-style refactor review start-project test translate; do
  mkdir -p ~/.claude/skills/$skill
  cp configs/skills/$skill/SKILL.md ~/.claude/skills/$skill/SKILL.md
done
```

### 개별 파일 복원

특정 파일만 복원하려면 해당 파일만 복사하면 됩니다.

```bash
# 예: settings.json만 복원
cp configs/settings.json ~/.claude/settings.json
```

## 원본 대비 변경 사항

이 백업에서 원본과 다른 부분은 다음과 같습니다.

- **settings.json**: RTK 훅 경로를 `/Users/kanghaeseok/.claude/hooks/rtk-rewrite.sh`에서 `$HOME/.claude/hooks/rtk-rewrite.sh`로 변경하여 이식성(Portability) 확보
- **configs/**: RTK 훅 스크립트 파일 자체는 더 이상 이 저장소에 포함하지 않음. 필요하면 RTK 설치 과정에서 생성된 로컬 파일을 사용해야 함.
- **settings.json**: 중복 플러그인 `"example-skills@anthropic-agent-skills": true` 항목 제거 (`document-skills@anthropic-agent-skills`만 유지)

## 백업 일자

2026-03-30
