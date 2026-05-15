# Marketing Skills

> 33개 마케팅 전문 스킬 세트 -- CRO, 카피라이팅(Copywriting), SEO, 이메일, 그로스 해킹(Growth Hacking) 등 마케팅 전 영역 커버

## 소개

마케팅 실무에 필요한 33개 전문 스킬을 하나의 세트로 제공한다.
`product-marketing-context` 스킬이 기반이 되어, 나머지 모든 스킬이 제품/고객/포지셔닝을 이해한 상태에서 작동한다.
특정 플랫폼에 종속되지 않으며, 스킬을 지원하는 AI 코딩 도구에서 범용적으로 사용할 수 있다.

## 주요 기능

### SEO / 콘텐츠(Content)
- seo-audit, ai-seo, site-architecture, programmatic-seo, schema-markup, content-strategy

### CRO (Conversion Rate Optimization)
- page-cro, signup-cro, onboarding, form-cro, popup-cro, paywall

### 카피 / 이메일(Email)
- copywriting, copy-editing, cold-email, email-sequence, social

### 광고 / 측정(Analytics)
- paid-ads, ad-creative, ab-test-setup, analytics-tracking

### 그로스 / 리텐션(Retention)
- referral, free-tool, churn-prevention

### 세일즈 / GTM (Go-To-Market)
- revops, sales-enablement, launch-strategy, pricing-strategy, competitor-alternatives

### 전략(Strategy)
- marketing-ideas, marketing-psychology

### 콘텐츠 확장(Content Scaling)
- lead-magnets, social-content

## 공식 링크
- GitHub: https://github.com/coreyhaines31/marketingskills

## 설치 (Claude Code 기준)

```bash
mkdir -p ~/.claude/plugins/repos ~/.claude/skills
git clone --depth 1 https://github.com/coreyhaines31/marketingskills.git ~/.claude/plugins/repos/marketing-skills

# 40개 스킬 일괄 심링크
for skill in ~/.claude/plugins/repos/marketing-skills/skills/*/; do
  ln -sfn "$skill" ~/.claude/skills/$(basename "$skill")
done
```

설치 결과: ab-testing, ad-creative, ads, ai-seo, analytics, aso, churn-prevention, co-marketing, cold-email, community-marketing, competitor-profiling, competitors, content-strategy, copy-editing, copywriting, cro, customer-research, directory-submissions, emails, free-tools, image, launch, lead-magnets, marketing-ideas, marketing-psychology, onboarding, paywalls, popups, pricing, product-marketing, programmatic-seo, referrals, revops, sales-enablement, schema, seo-audit, signup, site-architecture, social, video (총 40개. doc 인덱스의 33개에서 증가).

### 업데이트
```bash
cd ~/.claude/plugins/repos/marketing-skills && git pull
```
