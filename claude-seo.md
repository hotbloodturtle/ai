# Claude SEO

> 13개 서브스킬(Sub-skill)과 7개 서브에이전트(Sub-agent)로 구성된 종합 SEO 스킬 세트

## 소개

SEO 전 영역을 커버하는 종합 스킬 세트다.
Core Web Vitals 분석, E-E-A-T 평가, 스키마 마크업(Schema Markup) 검증/생성, AI 검색 최적화(GEO) 등을 지원한다.
특정 플랫폼에 종속되지 않으며, 스킬을 지원하는 AI 코딩 도구에서 범용적으로 사용할 수 있다.

## 주요 기능

- **사이트 감사(audit)**: 전체 사이트 SEO 감사, 최대 500페이지 크롤링
- **단일 페이지 분석(page)**: 온페이지(On-page) 요소, 콘텐츠 품질, 기술 메타 태그
- **기술 SEO(technical)**: 크롤러빌리티(Crawlability), 인덱서빌리티(Indexability), 보안, Core Web Vitals (LCP, INP, CLS)
- **스키마(schema)**: JSON-LD 구조화 데이터 탐지/검증/생성
- **콘텐츠(content)**: E-E-A-T 신호 분석, 가독성, 씬 콘텐츠(Thin Content) 탐지
- **AI 검색 최적화(geo)**: Google AI Overviews, ChatGPT, Perplexity 대응
- **사이트맵(sitemap)**: XML 사이트맵 검증/생성
- **이미지(images)**: 이미지 최적화 분석 (alt 텍스트, 파일 크기, 포맷)
- **hreflang**: 다국어 SEO 검증
- **프로그래매틱(programmatic)**: 대규모 데이터 기반 페이지 생성 SEO
- **경쟁사(competitor-pages)**: "X vs Y", "alternatives to X" 페이지 생성
- **로컬(local)**: 지역 SEO 분석
- **DataForSEO MCP 연동**: 실시간 SERP 데이터, 키워드 지표, 백링크(Backlink) 분석

## 공식 링크
- GitHub: https://github.com/AgriciDaniel/claude-seo

## 설치

### 사전 요구사항
- **Python 3.10+ 필수**. macOS 시스템 기본 Python은 3.9이므로 brew로 별도 설치 필요.

```bash
brew install python@3.11
# python3 명령이 3.11을 가리키도록 PATH에 prepend
export PATH="/opt/homebrew/opt/python@3.11/libexec/bin:$PATH"
# 영구 적용:
echo 'export PATH="/opt/homebrew/opt/python@3.11/libexec/bin:$PATH"' >> ~/.zshrc
```

### 공식 인스톨러
```bash
git clone --depth 1 https://github.com/AgriciDaniel/claude-seo.git ~/.claude/plugins/repos/claude-seo
bash ~/.claude/plugins/repos/claude-seo/install.sh
```

설치 결과:
- `~/.claude/skills/seo/` (SKILL.md + `.venv` + Playwright Chrome). `.venv`는 install.sh가 감지한 3.10+ 인터프리터로 생성된다 — brew `python@3.11`이 없어도 3.10+만 잡히면 동작.
- `~/.claude/skills/seo-*/` 서브스킬 16개 (seo-audit, seo-page, seo-technical, seo-schema, seo-content, seo-geo, seo-local, seo-maps, seo-images, seo-sitemap, seo-hreflang, seo-programmatic, seo-competitor-pages, seo-dataforseo, seo-plan, seo-image-gen)
- `~/.claude/agents/seo-*.md` **서브에이전트 10개**: seo-content, seo-dataforseo, seo-geo, seo-image-gen, seo-local, seo-performance, seo-schema, seo-sitemap, seo-technical, seo-visual
- DataForSEO MCP (옵션)

### 검증된 함정
- 시스템 Python 3.9에서 `install.sh` 실행 시 `Python 3.10+ is required`로 즉시 실패. Python 3.10+ 확보 필수(brew `python@3.11` 또는 uv/pyenv 등).
- Claude Code 자동 분류기가 외부 install.sh 실행을 차단할 수 있음 → 사용자 직접 실행 권장.

---

## Codex

같은 제작자의 [codex-seo](https://github.com/AgriciDaniel/codex-seo)를 사용한다. Claude SEO의 `.claude/agents`를 그대로 복사하지 않는다.

macOS에서 Python 3.11과 PDF 시스템 라이브러리를 먼저 준비한다:

```bash
brew install python@3.11 pango
mkdir -p "$HOME/.local/share/ai-tools"
git clone --depth 1 --branch v1.9.6-codex.5 https://github.com/AgriciDaniel/codex-seo.git "$HOME/.local/share/ai-tools/codex-seo"
cd "$HOME/.local/share/ai-tools/codex-seo"
# install.sh 내용을 확인한 뒤 실행
PATH="$(brew --prefix python@3.11)/libexec/bin:$PATH" bash install.sh
```

설치기는 `~/.codex/skills/seo*`와 `~/.codex/agents/seo-*.toml`을 교체한다. 기존 SEO 설치가 있다면 먼저 백업한다. 기본 ref는 v1.9.6-codex.5이며 `CODEX_SEO_REF`로 선택할 수 있다. 일반 Linux는 Python 3.10+와 Pango 등 배포판 의존성을 준비한 후 `bash install.sh`; Windows는 upstream의 `install.ps1`을 따른다.

```bash
"${CODEX_HOME:-$HOME/.codex}/skills/seo/.venv/bin/python"   "${CODEX_HOME:-$HOME/.codex}/skills/seo/scripts/verify_environment.py" --json
```

2026-09 검증에서 시스템 Python 3.9로는 실패했다. Pango가 없으면 WeasyPrint 경고가 JSON 앞에 섞여 bootstrap의 `verification`이 null이 되고 `AttributeError`가 날 수 있었다. `brew install pango` 후 설치기를 다시 실행하고 verifier의 `full_ready`를 확인한다. 라이브러리 탐색이 계속 실패하면 [WeasyPrint 공식 문제 해결](https://doc.courtbouillon.org/weasyprint/stable/first_steps.html#missing-library)을 따른다.

Google API 패키지 설치는 계정 인증 완료와 다르다. Google OAuth, DataForSEO, Firecrawl, Gemini 등은 해당 기능을 사용할 때 별도로 연결한다. 마케팅 스킬의 seo-audit와 중복 설치하지 않는다.
