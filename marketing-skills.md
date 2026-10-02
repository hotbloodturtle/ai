# Marketing Skills

> 50개 마케팅 전문 스킬 세트 -- CRO, 카피라이팅, SEO, 광고, 이메일, 그로스, 세일즈 등 마케팅 전 영역 커버 (2026-10-02 기준)

## 소개

`product-marketing` 스킬이 만드는 `.agents/product-marketing.md`가 기반 컨텍스트가 되어, 나머지 스킬이 제품/고객/포지셔닝을 이해한 상태에서 작동한다. 스킬 이름은 upstream에서 자주 바뀐다(예: `ab-test-setup`→`ab-testing`, `page-cro`→`cro`). 실제 목록은 `ls ~/.claude/plugins/repos/marketing-skills/skills`로 확인한다.

## 공식 링크
- GitHub: https://github.com/coreyhaines31/marketingskills

## 설치 (Claude Code 기준)

원본은 `~/.claude/plugins/repos/marketing-skills`에 clone하고, 각 스킬을 `~/.claude/skills/`로 **flat 심링크**한다(Claude Code는 한 단계만 스캔).

```bash
mkdir -p ~/.claude/plugins/repos ~/.claude/skills
git clone https://github.com/coreyhaines31/marketingskills.git ~/.claude/plugins/repos/marketing-skills

# seo-audit 제외(claude-seo 것을 쓴다), 이미 있는 이름은 건드리지 않음
for skill in ~/.claude/plugins/repos/marketing-skills/skills/*/; do
  name=$(basename "$skill")
  [ "$name" = seo-audit ] && continue
  [ -e ~/.claude/skills/"$name" ] && continue
  ln -s "$skill" ~/.claude/skills/"$name"
done
```

설치 결과: 50개 중 seo-audit 제외 49개 활성화.

### 검증된 함정
- `seo-audit`는 claude-seo와 이름이 겹친다. `~/.claude/skills/seo-audit`는 **claude-seo가 만든 실제 폴더**여야 한다. 마케팅 원본으로 가는 심링크로 두면 claude-seo `install.sh`가 심링크를 따라가 **마케팅 원본 파일을 덮어쓴다**(2026-10-02 실제 발생, 복구함).
- 레포만 clone하고 심링크를 안 하면 스킬이 비활성 상태다.

### 업데이트
```bash
cd ~/.claude/plugins/repos/marketing-skills && git pull --ff-only
# 새 스킬은 위 심링크 루프를 다시 실행(기존 이름은 건너뜀)
```

---

## Codex

[upstream](https://github.com/coreyhaines31/marketingskills)은 Codex를 지원한다. `skill-installer`로 `skills/` 아래 개별 스킬을 `~/.agents/skills/`에 설치한다. 수동 방식은 [Document Skills의 복사 루프](document-skills.md#codex)를 같은 저장소 구조에 적용하되, SEO suite를 함께 쓰면 `seo-audit`를 제외한다.

```bash
mkdir -p "$HOME/.local/share/ai-tools"
git clone --depth 1 https://github.com/coreyhaines31/marketingskills.git "$HOME/.local/share/ai-tools/marketingskills"
```

스킬 수·이름은 버전에 따라 달라진다. 2026-09-08에는 seo-audit 제외 49개를 설치했으며, 과거 본문의 33개는 당시 버전 기준이다. 이미 같은 이름이 있으면 덮어쓰기 전에 출처를 확인한다.
