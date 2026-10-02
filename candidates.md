# 평가한 도구와 보류 목록

평가했지만 설치하지 않았거나 일부만 설치한 도구. 같은 도구를 재평가하지 않도록 판단 근거와 "언제 설치할지"를 남긴다. 평가 기준은 **토큰 비용**(상시 + 호출당)과 **기존 도구와의 중복**.

## 조건부 설치 대기

| 대상 | 설치할 때 | 설치 방법 | 비고 |
|------|-----------|-----------|------|
| mattpocock `improve-codebase-architecture` + `codebase-design` + `domain-modeling` | 큰 코드베이스 구조 정리 | `npx -y skills add mattpocock/skills --skill <이름> ... -g -y -a claude-code` | 묶음으로만 동작(`grilling`·`GLOSSARY.md` 의존) |
| [ui-ux-pro-max](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) `ui-ux-pro-max` 스킬만 | 앱 UI 품질 개선 시 **app-auto 레포에 프로젝트 단위로** | 스킬 폴더(`.claude/skills/ui-ux-pro-max`)만 복사 | 전역 제외 이유: description이 모든 UI 작업에 트리거(+5–6k 토큰), Hallmark·frontend-design과 중복, 키워드 검색 품질 보통. 플러그인은 기존 `design`과 이름 충돌하는 7개 스킬 동반 |
| [pm-skills](https://github.com/phuryn/pm-skills) `pm-product-discovery`, `pm-product-strategy` | 새 제품 기획 | `claude plugin marketplace add phuryn/pm-skills` → `claude plugin install <플러그인>@pm-skills --scope project` | `--scope project` 동작 미검증 |
| [agent-skills](https://github.com/addyosmani/agent-skills) `api-and-interface-design`, `observability-and-instrumentation` 등 | 해당 작업 본격 착수 | `npx -y skills add addyosmani/agent-skills --skill <이름> -g -y -a claude-code` | 하나씩만 |

## 설치하지 않음

| 대상 | 평가일 | 판단 | 이유 |
|------|--------|------|------|
| [pm-skills](https://github.com/phuryn/pm-skills) (전체) | 2026-10-02 | 보류 | 69개 스킬, 대부분 Marketing Skills·BMAD·gstack과 중복. 이름 충돌(`retro`, `marketing-ideas`, `pricing`). 순수 마크다운이라 위험은 없음 |
| [last30days](https://github.com/mvanhorn/last30days-skill) | 2026-10-02 | 제외 | `SKILL.md` 260KB → **호출당 ~65k 토큰**. X 무료 경로는 브라우저 쿠키 추출(계정 위험), 첫 실행 시 외부 CLI 자동 설치. 필요하면 스킬 대신 엔진 CLI(`python3 scripts/last30days.py "주제"`)만 사용 |
| [agent-skills](https://github.com/addyosmani/agent-skills) (전체) | 2026-10-02 | 제외 | 25개 중 대부분 Superpowers·Spec Kit·gstack·내장 명령과 중복. `test-driven-development` 이름 충돌, `/review`·`/ship` 명령 충돌. 스킬당 ~13.5KB |
| [mattpocock/skills](https://github.com/mattpocock/skills) (나머지) | 2026-10-02 | 제외 | `tdd`·`diagnosing-bugs`·`code-review`·`retro`·`handoff` 등 기존과 중복, `to-spec`·`triage` 등은 레포별 이슈 트래커 셋업 필요. 선별 3개는 [mattpocock-skills.md](mattpocock-skills.md) |
| [taste-skill](https://github.com/Leonxlnx/taste-skill) | 2026-10-02 | 제외 | Hallmark(사용 중)와 같은 안티 AI-slop 디자인 목적. 메인 스킬 87KB(~22k 토큰)로 더 큼. `output-skill`은 "모든 작업"에 완전 출력 강제 → 토큰 증가 |
| Superpowers `diagnosing-superpowers` | 2026-10-02 | 제외 | 메인테이너용 버그 리포트 스킬, description 오발동 위험 ([superpowers.md](superpowers.md)) |
| Document Skills `academy-guide`, `discernment-nudge` | 2026-10-02 | 제외 | 거의 모든 답변 직전에 호출되도록 트리거 → 답변당 수천 토큰 ([document-skills.md](document-skills.md)) |
| Archify `archify-review` | 2026-10-02 | 제외 | archify 레포 관리용 리뷰 스킬, description 오발동 위험 ([archify.md](archify.md)) |

