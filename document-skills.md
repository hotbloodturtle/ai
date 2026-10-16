# Document-Skills (anthropics/skills)

> Anthropic 공식 스킬 세트 -- 오피스 문서, 디자인, API 개발 등 17개 스킬 포함

## 소개
Anthropic이 공식 제공하는 범용 스킬 모음이다. PDF, XLSX, PPTX, DOCX 등 오피스 문서 생성/편집은 물론 프론트엔드 디자인, 알고리즘 아트(Algorithmic Art), MCP 서버 빌더 등 다양한 역할을 수행한다. `document-skills`와 `example-skills`는 동일한 스킬 세트이므로 하나만 설치하면 된다.

## 주요 기능
- pdf: PDF 생성, 편집, 양식(Form) 작성
- xlsx: 스프레드시트(Spreadsheet) 수식, 서식, 분석
- pptx: 프레젠테이션(Presentation) 생성/편집
- docx: 문서 생성, 추적 변경(Track Changes), 서식 유지
- frontend-design: 프로덕션급(Production-grade) 프론트엔드 인터페이스 생성
- canvas-design: PNG/PDF 비주얼 아트(Visual Art) 디자인
- mcp-builder: MCP 서버 개발 가이드
- skill-creator: 새 스킬 작성 가이드
- 기타: algorithmic-art, brand-guidelines, doc-coauthoring, internal-comms, slack-gif-creator, theme-factory, web-artifacts-builder, webapp-testing, claude-api

## 공식 링크
- GitHub: https://github.com/anthropics/skills

## 설치 (Claude Code 기준)

이 환경은 **방법 A(clone + 심링크)**를 쓴다(스킬 단위 제외 가능).

### 방법 A: git clone + 심링크 (채택)
```bash
mkdir -p ~/.claude/plugins/repos ~/.claude/skills
git clone https://github.com/anthropics/skills.git ~/.claude/plugins/repos/document-skills

# academy-guide, discernment-nudge 제외
for skill in ~/.claude/plugins/repos/document-skills/skills/*/; do
  name=$(basename "$skill")
  case "$name" in academy-guide|discernment-nudge) continue;; esac
  ln -sfn "$skill" ~/.claude/skills/"$name"
done
```

설치 결과(17개): algorithmic-art, brand-guidelines, canvas-design, claude-api, doc-coauthoring, docx, frontend-design, internal-comms, mcp-builder, pdf, pptx, skill-creator, slack-gif-creator, theme-factory, web-artifacts-builder, webapp-testing, xlsx.

제외(2026-10-02, 토큰 비용):
- `academy-guide` (7.7KB): Claude 사용법 질문마다 "답변 마무리 전 확인"하도록 트리거.
- `discernment-nudge` (10.6KB): 실질적인 답변·초안마다 "최종 답변 전 호출"하도록 트리거 → 답변당 ~2.7k 토큰.

참고:
- claude.ai 계정 로그인 시 `anthropic-skills:docx/pdf/pptx/xlsx/skill-creator`가 별도로 노출되어 목록에 두 번 보인다. 목록 예산만 조금 더 쓰고 동작 문제는 없다. API 키 로그인에서는 계정 스킬이 없으므로 로컬 심링크를 유지한다.
- `claude-api`는 description 트리거가 넓다(Claude·Anthropic 언급 시). Claude API 개발을 안 하는 기기는 심링크를 빼도 된다.

### 방법 B: 플러그인 마켓플레이스
```bash
/plugin marketplace add anthropics/skills
/plugin install document-skills@anthropic-agent-skills
```
`document-skills:<스킬명>` 네임스페이스. 전체 설치라 위 제외가 안 된다. 방법 A와 동시에 쓰지 않는다.

### 업데이트
```bash
cd ~/.claude/plugins/repos/document-skills && git pull --ff-only
ls skills   # 새 스킬이 있으면 비용·트리거 확인 후 심링크
```
