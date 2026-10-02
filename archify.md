# Archify

설명·Mermaid·실제 코드로부터 **검증된 인터랙티브 다이어그램 HTML**을 만드는 스킬. 아키텍처·워크플로·시퀀스·데이터흐름·라이프사이클(상태) 5종을 지원한다. 에이전트가 JSON을 쓰고 내장 렌더러의 `finalize`가 겹침·누락·라우팅을 검사해 단일 HTML(다크/라이트, 경로 강조·하류 추적, PNG/SVG/WebM 내보내기)로 만든다.

- 공식: https://github.com/tt-a1i/archify
- 라이선스: MIT (75k+ 스타, 활발히 유지됨)
- 요구: Node 18+ (런타임 의존성 없음)

---

## 비용 (토큰)

| 상황 | 대략 |
|------|------|
| 상시 (스킬 목록 description) | ~150 토큰 |
| 정상 생성 1회 (SKILL.md 11KB + 기본값·예시·스키마 + 결과 JSON) | ~12–15k |
| 검증 실패 → 수리 (계약 문서 27–42KB 추가 로드) | ~30–40k |
| 비교: 스킬 없이 직접 그림 | ~5–8k |

**쓰는 기준**: 공유·문서용으로 정확해야 하는 다이어그램, 레포 근거가 필요한 구조도에만 쓴다. 간단한 도식은 그냥 그려달라고 요청한다.

---

## 설치

```bash
npx -y skills add tt-a1i/archify -g -y -a claude-code
npx -y skills remove archify-review -g -y -a claude-code   # 함께 깔리는 메인테이너용 리뷰 스킬 제거
node ~/.claude/skills/archify/bin/archify.mjs doctor          # "Archify is ready." 확인
```

- 레포에 스킬이 2개(`archify`, `archify-review`) 있어 둘 다 설치된다. `archify-review`는 archify 레포 자체의 이슈/PR 리뷰용인데 description이 넓어("change reviews, code quality") 일반 리뷰에 오발동할 수 있으므로 제거한다.
- `-g`/`-a` 플래그 함정은 [Hallmark](hallmark.md#설치)와 동일.
- 업데이트 확인: 하루 1회 정도 고정 manifest를 GET해 알림만 띄운다(자동 설치 없음, 버전·프로젝트 정보 미전송). `~/.claude/settings.json`의 `env.ARCHIFY_UPDATE_CHECK_DISABLED=1`로 끈다(RTK 텔레메트리와 같은 원칙).

업데이트:
```bash
npx -y skills update -g
```

---

## 사용법

```
"archify로 이 레포 아키텍처 그려줘"             → 소스 근거(파일 링크) 포함 구조도
"로그인 요청 시퀀스 다이어그램으로"               → sequence
"이 Mermaid 예쁘게 바꿔줘" + 코드 붙여넣기         → Mermaid 변환
"캐시 미스 경로 강조해줘" / "라이트 테마로"        → 같은 폴더에서 반복 수정
```

산출물은 작업 디렉토리의 `.archify/<type>-<slug>-<시각>/` 아래 `candidate.json` + `.html`. 레포에 커밋하지 않으려면 `.gitignore`에 `.archify/`를 추가한다.

---

## 기존 도구와의 관계

| 도구 | 관계 |
|------|------|
| `artifact-diagramming` (내장) | 아티팩트용 SVG 작성 요령. Archify는 검증 엔진·인터랙션·소스 링크까지 가진 전용 도구 |
| [Codebase Memory](codebase-memory.md) `get_architecture` | 구조를 텍스트로 파악 → Archify로 시각화. 보완 |
| [explain-diff](explain-diff.md) | diff 설명용. 겹치지 않음 |

---

## Codex

upstream이 Codex를 지원한다(`~/.agents/skills/`).

```bash
npx -y skills add tt-a1i/archify -g -y -a codex
```

이번 기기에서는 Codex 설치를 검증하지 않았다.
