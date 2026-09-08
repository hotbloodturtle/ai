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

### 방법 A: 플러그인 마켓플레이스 (권장)
```bash
/plugin marketplace add anthropics/skills
/plugin install document-skills@anthropic-agent-skills
# example-skills도 동일 세트 — 하나만 설치하면 된다
```
스킬이 `document-skills:<스킬명>` 네임스페이스로 등록된다. `~/.claude/plugins/repos/`는 사용하지 않는다.

### 방법 B: git clone + 심링크 (수동)
```bash
mkdir -p ~/.claude/plugins/repos ~/.claude/skills
git clone --depth 1 https://github.com/anthropics/skills.git ~/.claude/plugins/repos/document-skills

# 17개 스킬 일괄 심링크
for skill in ~/.claude/plugins/repos/document-skills/skills/*/; do
  ln -sfn "$skill" ~/.claude/skills/$(basename "$skill")
done
```

설치 결과: algorithmic-art, brand-guidelines, canvas-design, claude-api, doc-coauthoring, docx, frontend-design, internal-comms, mcp-builder, pdf, pptx, skill-creator, slack-gif-creator, theme-factory, web-artifacts-builder, webapp-testing, xlsx (총 17개).

### 업데이트
```bash
cd ~/.claude/plugins/repos/document-skills && git pull
```

---

## Codex

Claude의 `/plugin install` 대신 개별 `skills/<name>` 폴더를 `~/.agents/skills/`에 설치한다. Codex `skill-installer`에 `anthropics/skills`의 필요한 스킬을 요청하거나 다음처럼 독립 clone에서 복사한다.

```bash
mkdir -p "$HOME/.local/share/ai-tools" "$HOME/.agents/skills"
git clone --depth 1 https://github.com/anthropics/skills.git "$HOME/.local/share/ai-tools/document-skills"
for skill in "$HOME/.local/share/ai-tools/document-skills/skills/"*/; do
  name="$(basename "$skill")"
  case "$name" in skill-creator|claude-api) continue ;; esac
  target="$HOME/.agents/skills/$name"
  if [ ! -e "$target" ] && [ ! -L "$target" ]; then cp -R "$skill" "$target"; fi
 done
```

기존 clone이 있으면 다시 clone하지 않고 상태 확인 후 갱신한다. 시스템 `skill-creator`와 중복되는 스킬은 제외하고, Claude API 개발을 하지 않으면 `claude-api`도 제외한다. 원본의 LICENSE 및 스킬별 라이선스를 유지한다. 설치 후 실제 문서 작업에 필요한 Python/Node 패키지, LibreOffice 등은 해당 SKILL.md에 따라 추가한다. 파일 설치와 문서 생성 검증은 별개다.

[Anthropic 원본](https://github.com/anthropics/skills) · [공통 설치 가이드](setup-guide.md)

### 공용 문서 런타임

upstream SKILL.md의 “preinstalled”는 배포 환경의 가정이다. 일반 개인 기기의 시스템 Python/Node에 패키지가 이미 있다는 의미가 아니다. 프로젝트 의존성과 분리해 준비할 수 있다.

```bash
uv venv --python 3.11 "$HOME/.local/share/ai-tools/document-runtime/.venv"
uv pip install --python "$HOME/.local/share/ai-tools/document-runtime/.venv/bin/python" \
  pypdf pdfplumber reportlab openpyxl pandas 'markitdown[docx,pptx,xlsx,pdf]' \
  pillow defusedxml lxml python-docx
npm install --prefix "$HOME/.local/share/ai-tools/document-runtime" \
  docx pptxgenjs sharp react react-dom react-icons
# macOS: 렌더링·변환·스프레드시트 수식 재계산
brew install pandoc poppler
brew install --cask libreoffice
```

Python 스크립트는 위 venv의 `bin/python`으로 실행한다. Node 스크립트는 `NODE_PATH="$HOME/.local/share/ai-tools/document-runtime/node_modules" node script.cjs`처럼 실행한다. `npm --prefix` 설치만으로 모든 프로젝트에서 require가 자동 해결되지는 않는다. 해당 경로 사용법을 개인 AGENTS.md/CLAUDE.md에 적어 두면 된다.

Windows venv는 `Scripts/python.exe`, Node 환경변수는 PowerShell 문법을 사용한다. LibreOffice·Pandoc·Poppler는 각 OS 설치 경로를 확인한다. 이 런타임 구성은 기본 PDF/DOCX/PPTX/XLSX 생성·읽기의 준비이며, 복잡한 레이아웃/폰트/매크로 호환성은 산출물별로 검증한다.
