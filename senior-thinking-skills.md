# Senior Thinking Skills — 선별 참고자료

개발 판단 원칙을 작은 스킬로 나눈 모음이다. 이 레포에서는 **선택·참고용**으로 보관한다. 기본 설치 목록이나 전역 자동 호출에는 추가하지 않는다.

- 원본: [songjiun10-collab/Senior-thinking-skills](https://github.com/songjiun10-collab/Senior-thinking-skills)
- 검토일: 2026-09-17
- 검토 기준: [`be98e588`](https://github.com/songjiun10-collab/Senior-thinking-skills/tree/be98e588b4b5455b5ca95c11d2beacdfef4360be), `SKILL.md` 24개 원문
- 범위: 문서 내용과 기존 구성의 중복 검토. 설치·훅 실행·실제 작업 성능은 검증하지 않았다.

## 채택한 활용 방식

주 계획 워크플로는 기존처럼 하나를 선택한다. 아래 원칙은 관련 작업에서 그 워크플로의 설계 메모·검증 결과에 반영한다. 별도 승인 단계나 문서를 매번 만들 필요는 없다.

| 참고 스킬 | 사용할 때 | 반영할 내용 |
|---|---|---|
| [record-the-why](https://github.com/songjiun10-collab/Senior-thinking-skills/blob/be98e588b4b5455b5ca95c11d2beacdfef4360be/record-the-why/SKILL.md) | 도구 채택·교체, 아키텍처·공개 API·데이터 형식 결정 | 결정, 제외한 대안, 선택 이유를 기존 문서·커밋·ADR 관례에 맞춰 남긴다. 쉽게 되돌릴 수 있는 자명한 변경은 생략한다. |
| [premortem](https://github.com/songjiun10-collab/Senior-thinking-skills/blob/be98e588b4b5455b5ca95c11d2beacdfef4360be/premortem/SKILL.md) | 외부 API, 결제, 동시 실행, 데이터 저장 | 해당 작업의 타임아웃·중복 요청·부분 저장 등 실제 실패 경로와 실패를 알아채는 방법을 점검한다. |
| [honest-artifacts](https://github.com/songjiun10-collab/Senior-thinking-skills/blob/be98e588b4b5455b5ca95c11d2beacdfef4360be/honest-artifacts/SKILL.md) | 성능 측정, SEO·데이터 분석, 수치·임계값 보고 | 검증값과 추정값을 구분하고 입력·버전·재현 절차를 남긴다. 지표 개선과 실제 목적 달성을 구분한다. |

### 사용 예시

설치 없이 이 문서를 작업 요청에 지정하면 된다. Claude와 Codex 모두 문서를 읽고 관련 원칙을 적용하는 방식이다.

```text
senior-thinking-skills.md의 record-the-why 기준으로 이번 도구 선택의
결정·제외 대안·이유를 기존 문서에 남겨줘.
```

```text
senior-thinking-skills.md의 premortem 기준으로 이번 저장 흐름의
중복 요청·부분 저장·실패 감지를 점검하고 필요한 부분만 반영해줘.
```

## 전체 설치를 제외한 이유

| 대상 | 기존 구성과의 관계 |
|---|---|
| root-cause-discipline | Superpowers systematic-debugging과 중복 |
| bite-sized-plan, clarify-the-real-problem | Superpowers 계획·브레인스토밍과 중복 |
| verify-before-claiming, verifiability-first | 완료 전 검증·TDD와 중복 |
| simplicity-budget, surgical-change, chestertons-fence | Ponytail의 최소 구현·범위 유지·변경 전 이해 원칙과 중복 |
| fresh-context-review, delegate-to-subagents | 기존 리뷰·위임 워크플로와 중복 |
| context-economy, persistent-memory | planning-with-files·기존 메모리 구성과 목적 중복. 기능이 동등하다는 의미는 아님 |

원본도 Superpowers 등 기존 프로젝트의 원칙을 재구성했다고 설명한다. 현재 구성에 전체 묶음을 더하면 유사한 트리거와 절차를 함께 유지해야 하므로, 추가 이익보다 중복 관리 부담이 크다고 판단했다.

## 원문을 그대로 적용하지 않는 부분

- **라우터:** 작은 변경도 설계를 제시하고 멈추라는 지침과, 방향이 명확하면 계속 진행하라는 지침이 함께 있다. 기존 계획 워크플로 위에 또 다른 중단 기준을 추가하지 않는다.
- **interface-contracts:** 관찰 가능한 동작까지 호환성으로 점검하는 원칙은 유용하다. 다만 API·의존성 버전을 하나만 허용하는 절대 규칙은 채택하지 않는다. 외부 소비자의 단계적 이전이 필요한 경우를 따로 판단한다.
- **delegate-to-subagents:** 실행 중 메시지 교환 설명과 중간 상태 채널이 없다는 설명이 함께 있어 환경별 해석이 필요하다. 제공 훅의 Claude 도구 이름·이벤트를 Codex에 그대로 복사하지 않는다.
- **조직 규모별 관점:** Principal·Distinguished·Executive 관점은 해당 영향 범위가 실제로 있는 작업에만 참고한다. 작은 수정에 조직·예산 검토를 의무화하지 않는다.

위 판단의 원문: [라우터](https://github.com/songjiun10-collab/Senior-thinking-skills/blob/be98e588b4b5455b5ca95c11d2beacdfef4360be/senior-engineer-mindset/SKILL.md), [인터페이스 계약](https://github.com/songjiun10-collab/Senior-thinking-skills/blob/be98e588b4b5455b5ca95c11d2beacdfef4360be/interface-contracts/SKILL.md), [위임](https://github.com/songjiun10-collab/Senior-thinking-skills/blob/be98e588b4b5455b5ca95c11d2beacdfef4360be/delegate-to-subagents/SKILL.md).

## 재검토 조건

선별 원칙을 반복해서 수동 지정하게 되거나, 기존 워크플로가 같은 실수를 반복할 때 해당 원칙만 독립 스킬로 도입할지 검토한다. 이때 실제 작업 사례로 효과와 불필요한 중단 여부를 확인하고 Claude/Codex 실행 검증을 별도로 기록한다.
