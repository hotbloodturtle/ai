# Codex Master Setup Design

## Goal

`claude-code-master-setup.md`의 장점을 유지하면서, Claude 전용 개념을 억지로 옮기지 않고 현재 개인용 Codex 환경에 맞는 설치 중심 문서를 만든다.

핵심 목표는 두 가지다.

1. 새 Mac이나 새 작업 환경에서 Codex 세팅을 다시 만들 수 있어야 한다.
2. 설치가 끝난 뒤 Codex가 어떤 원칙으로 일해야 하는지 개인 운영 규약까지 함께 고정해야 한다.

## Audience

- 1인 사용자 전용
- macOS 기준
- 설치/복구를 자주 반복하는 사용자
- `MCP`, `skills`, `AGENTS.md`, `subagent`, `Playwright`, `android-qa-agent`까지 적극 활용하려는 사용자

## Non-Goals

- Claude Code 문서를 1:1로 번역하지 않는다.
- Cowork/Desktop 전용 기능을 Codex 문서 본문에 넣지 않는다.
- 팀 공용 거버넌스 문서로 확장하지 않는다.
- 실제 비밀값(API 키, 액세스 토큰, DSN)을 문서에 넣지 않는다.

## Primary Decisions

### 1. 문서 유형

`설치 중심 + 운영 보조형`으로 간다.

- 설치/설정/검증/복구: 약 70%
- 개인 운영 원칙: 약 30%

이렇게 해야 문서가 실제로 재설치 런북 역할을 하면서도, 세팅 후 Codex의 행동 규약까지 남길 수 있다.

### 2. 문서 위치

최종 문서는 저장소 루트의 `codex-master-setup.md`에 둔다.

이 저장소가 이미 `ANDROID_QA_AGENT_SETUP.md`, `claude-code-master-setup.md`처럼 실행형 문서를 루트에 두고 있으므로 같은 패턴을 유지한다.

### 3. 지원 범위

Codex에서 현재 확인 가능한 것만 본문에 쓴다.

- 로컬 CLI 확인: `codex --help`, `codex mcp --help`, `codex features list`
- 현재 로컬 설정 확인: `~/.codex/config.toml`, `~/.codex/skills`, `~/.codex/superpowers`
- 설치형 도구 확인: `playwright-cli --help`, `rtk --version`, `uv --version`

불확실한 항목은 다음 중 하나로 처리한다.

- 현재 환경 기준 사실로 서술
- 추론임을 명시
- Claude와 달리 재해석이 필요하다고 명시

### 4. Claude 대비 방식

비교는 본문 중심이 아니라 보조 자료로 넣는다.

- 본문: Codex 자체 설치와 운영
- 부록/초반 표: Claude 개념을 Codex에 어떻게 대응시키는지

## Section Plan

최종 문서는 아래 순서로 구성한다.

1. 개념 정리
2. 무엇이 그대로 되고 무엇이 달라지는가
3. 빠른 설치 가이드
4. 상세 설치 가이드
5. 검증 가이드
6. 개인 운영 프로필
7. 추천 조합
8. 트러블슈팅
9. 공식/로컬 참고 링크

## Content Rules

- 한국어 중심으로 쓴다.
- 설치 명령은 가능한 한 바로 실행 가능한 형태로 쓴다.
- 비밀값은 모두 placeholder로 바꾼다.
- `config.toml` 예시는 안전한 형태만 넣는다.
- `RTK`는 자동 훅이 아니라 현재 Codex에서의 현실적 사용 방식을 적는다.
- `frontend-design`과 `serena`는 현재 Codex 기본 내장으로 가정하지 않는다.
- 웹 테스트는 `playwright-cli` 우선, 그다음 `Playwright MCP` 순으로 정리한다.
- 앱 테스트는 승인 후 `android-qa-agent` 사용 원칙으로 정리한다.

## Verification Strategy

문서가 완료되면 아래를 점검한다.

1. 로컬 CLI에서 실제 확인한 명령만 설치/검증 섹션에 넣었는가
2. 문서에 실제 비밀값이 남지 않았는가
3. Codex와 Claude 개념을 혼동하지 않았는가
4. 설치 단계와 운영 단계가 분리되어 읽히는가
5. 루트 문서 스타일이 기존 실행형 문서 톤과 충돌하지 않는가

## Deliverables

- `docs/plans/2026-03-31-codex-master-setup-design.md`
- `docs/plans/2026-03-31-codex-master-setup-plan.md`
- `codex-master-setup.md`
