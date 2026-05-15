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
- `~/.claude/skills/seo/` (SKILL.md + .venv + Playwright Chrome)
- `~/.claude/agents/seo-*.md` 18개 서브에이전트
- DataForSEO MCP (옵션)

### 검증된 함정
- 시스템 Python 3.9에서 `install.sh` 실행 시 `Python 3.10+ is required`로 즉시 실패. 위 PATH 설정 필수.
- Claude Code 자동 분류기가 외부 install.sh 실행을 차단할 수 있음 → 사용자 직접 실행 권장.
