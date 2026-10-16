# Hallmark

AI 코딩 에이전트용 "안티 AI-slop" 디자인 스킬. AI가 만든 티 나는 UI(보라 그라데이션, hero → 3-feature → CTA 템플릿 반복)를 막고, 요청마다 다른 거시구조를 선택해 "생성된 게 아니라 만들어진" 사이트를 목표로 한다. Together AI의 Nutlope 제작.

- 공식: https://github.com/Nutlope/hallmark
- 라이선스: MIT (23k+ 스타, 활발히 유지됨)

---

## 핵심 개념

단순 스타일 가이드가 아니라 **워크플로 스킬**. 4가지 동작을 가진다.

| 동작 | 설명 |
|------|------|
| 기본 (생성) | 새 UI 요청 시 거시구조 선택 → 테마/규칙 적용 → 57개 품질 게이트 자체 검증 |
| `hallmark audit <대상>` | 기존 코드를 안티패턴 목록으로 채점, 순위별 개선 리스트 반환 (수정 안 함) |
| `hallmark redesign <대상>` | 콘텐츠·라우트·브랜드·정보구조 유지, 시각 구조만 재설계 |
| `hallmark study <스크린샷\|URL>` | 참고 디자인에서 DNA(구조·타이포·컬러 앵커) 추출 → 진단 리포트 또는 portable design.md 생성 |

차별점은 **구조적 다양성**: 서로 다른 브리프 두 개가 같은 섹션 리듬을 공유하지 않도록 강제한다. 21개 테마 + 템플릿 없는 Custom 모드 제공.

---

## 설치

```bash
# 글로벌 설치 (Claude Code)
npx -y skills add nutlope/hallmark -g -y -a claude-code
```

설치 경로: `~/.claude/skills/hallmark/` (SKILL.md + references/ 30여 개 규칙 파일)

주의:
- `-g` 없이 실행하면 프로젝트 레벨(`.agents/skills/` + `.claude/skills/` 심링크)로 설치됨
- `-a claude-code` 없이 `-g`만 주면 일부 에이전트(PromptScript 등)가 글로벌 미지원으로 실패함

업데이트:
```bash
npx -y skills update -g
```

---

## 사용법

```
"랜딩 페이지 만들어줘"                    → 스킬 트리거 시 자동 적용 (greenfield UI 요청)
"hallmark로 대시보드 만들어"               → 명시 호출
"hallmark audit src/pages/Home.tsx"       → 안티패턴 채점
"hallmark redesign 랜딩 페이지"            → 구조만 재설계
"hallmark study https://linear.app"       → 디자인 DNA 추출
```

`study`는 픽셀 복제를 거부하고 DNA(구조 패턴)만 추출한다. 템플릿 마켓 URL은 거부.

---

## Awesome Design MD와의 관계

역할이 달라 상호보완적. 둘 다 유지한다.

| 항목 | Awesome Design MD | Hallmark |
|------|-------------------|----------|
| 성격 | 레퍼런스 데이터 (실존 사이트 토큰 기록) | 워크플로 스킬 (생성·감사·재설계 + 품질 게이트) |
| 쓰임 | "Linear 스타일로" — 특정 스타일 모방 | "AI스럽지 않게" — 범용 품질 보장 |
| 출력 | DESIGN.md (구체적 토큰 값) | 완성 UI, 감사 리포트, design.md |

**권장 조합**: Hallmark로 구조·품질 확보 → 특정 브랜드 룩이 필요하면 awesome-design-md의 DESIGN.md로 토큰 지정. Hallmark `study`가 뽑은 design.md를 프로젝트 루트에 두면 awesome-design-md 워크플로우와 동일하게 참조된다.

frontend-design 스킬(Anthropic)과도 겹치지만, Hallmark가 그 스킬의 규칙을 이미 흡수·확장했다고 명시하고 있다.
