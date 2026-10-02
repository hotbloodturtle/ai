# Matt Pocock Skills (선별 3개)

Matt Pocock의 "작고 조합 가능한" 엔지니어링 스킬 모음 중 **3개만 골라** 전역 설치한다. 전체(27개)는 Superpowers·Spec Kit·gstack·내장 `/code-review`와 겹치고, 일부는 레포별 이슈 트래커 셋업을 요구한다.

- 공식: https://github.com/mattpocock/skills
- 라이선스: MIT (270k+ 스타, 활발히 유지됨)

---

## 설치한 스킬

| 스킬 | 호출 | 용도 | 1회 비용 |
|------|------|------|----------|
| `grilling` | 모델 자동 / "grill" 표현 | 계획·결정을 설계 트리로 쪼개 **질문을 라운드 단위로 묶어** 추천 답과 함께 묻는다. 사실 확인은 직접 조사 | ~500 토큰 |
| `grill-me` | `/grill-me` 전용 | `grilling` 진입점 (3줄) | ~0 |
| `writing-for-agents` | 모델 자동 (스킬·CLAUDE.md·AGENTS.md 작성/수정 시) | 에이전트용 문서 작성 가이드. 상시 로드되는 description을 최소화하는 기준 포함 | ~3k (+스킬 작성 시 `SKILL-MECHANICS.md`) |

상시 비용: description 2개(~100 토큰). `grill-me`는 `disable-model-invocation`이라 목록에 올라가지 않는다.

`grilling`은 Superpowers `brainstorming`(질문을 하나씩)보다 왕복이 적다. 둘 다 유지하되, 계획 검증은 `/grill-me`를 우선한다.

---

## 설치

```bash
npx -y skills add mattpocock/skills --skill grilling --skill grill-me --skill writing-for-agents -g -y -a claude-code
```

- 각 폴더의 `agents/openai.yaml`은 Codex 표시용 메타데이터라 Claude에는 영향 없다.
- 플러그인(`claude plugins install mattpocock-skills`)은 27개 전체가 설치되므로 쓰지 않는다. skills CLI와 동시 사용 시 중복된다.

업데이트:
```bash
npx -y skills update -g
```

---

## 사용법

```
/grill-me 이 마이그레이션 계획 검토해줘      → 질문 라운드 → 공유 이해 도달 후 실행
"이 설계 grill 해줘"                          → grilling 자동 호출
"새 스킬 만들어줘" / CLAUDE.md 수정           → writing-for-agents 자동 참조
```

---

## 보류한 스킬

[candidates.md](candidates.md) 참고 (`improve-codebase-architecture` 묶음 등).

---

## Codex

```bash
npx -y skills add mattpocock/skills --skill grilling --skill grill-me --skill writing-for-agents -g -y -a codex
```

이번 기기에서는 Codex 설치를 검증하지 않았다.
