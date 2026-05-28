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

레포는 `~/.claude/skills/marketing/`에 통째로 클론되어 있고, 스킬 33개는 `marketing/skills/` **하위**에 중첩되어 있다. Claude Code는 `~/.claude/skills/<스킬>/SKILL.md` **한 단계만** 스캔하므로, 중첩된 채로는 인식되지 않는다 → 각 스킬을 최상위로 **flat 심링크**해야 활성화된다.

```bash
git clone --depth 1 https://github.com/coreyhaines31/marketingskills.git ~/.claude/skills/marketing

# 스킬 일괄 flat 심링크 (seo-audit은 claude-seo와 이름 충돌 → 제외)
for skill in ~/.claude/skills/marketing/skills/*/; do
  name=$(basename "$skill")
  [ "$name" = "seo-audit" ] && continue   # claude-seo의 seo-audit 보존
  ln -sfn "$skill" ~/.claude/skills/"$name"
done
```

설치 결과 (실제 33개 스킬 디렉터리, seo-audit 제외 시 32개 활성화):
ab-test-setup, ad-creative, ai-seo, analytics-tracking, churn-prevention, cold-email, competitor-alternatives, content-strategy, copy-editing, copywriting, email-sequence, form-cro, free-tool-strategy, launch-strategy, lead-magnets, marketing-ideas, marketing-psychology, onboarding-cro, page-cro, paid-ads, paywall-upgrade-cro, popup-cro, pricing-strategy, product-marketing-context, programmatic-seo, referral-program, revops, sales-enablement, schema-markup, ~~seo-audit~~, signup-flow-cro, site-architecture, social-content.

### 검증된 함정
- 레포만 클론하고 flat 심링크를 안 하면 33개 스킬이 **디스크에만 있고 비활성** 상태가 된다 (스킬 목록에 안 뜸).
- `seo-audit`는 claude-seo 스킬과 이름이 겹친다. 둘 다 두면 충돌하므로 claude-seo 쪽을 보존하고 마케팅 seo-audit은 심링크에서 제외한다.

### 업데이트
```bash
cd ~/.claude/skills/marketing && git pull
```
