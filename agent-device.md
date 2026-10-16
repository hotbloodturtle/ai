# agent-device

> AI 코딩 에이전트가 실행 중인 앱에서 직접 변경사항을 검증하게 하는 크로스플랫폼 기기 자동화 CLI (Callstack 공식)

## 소개

React Native 코어 팀으로 알려진 Callstack이 만든 기기 자동화 도구다.
iOS/Android 시뮬레이터·에뮬레이터·실기기(+ tvOS, Android TV, macOS, 웹)를 하나의 CLI로 제어한다.
스크린샷 좌표 추측 대신 **접근성 스냅샷의 요소 ref**(`@e12`)로 조작하는 inspect-act-verify 루프가 핵심이라 에이전트 오조작이 적다.
`--settle` 옵션은 액션 후 UI가 안정될 때까지 기다렸다가 변경된 노드만 diff(+/-)로 반환해, 별도 스냅샷 재캡처 없이 다음 판단이 가능하다 (토큰 효율적).

기존 [android-qa-agent](android-qa-agent-setup.md)(Android 전용 ADB 래퍼, deprecated)의 상위 호환이다.

## 주요 기능

- devices / boot / open / close: 기기 목록, 부팅, 앱 실행·종료
- snapshot -i: 접근성 스냅샷 (요소 ref 부여)
- press / click / fill / longpress + `--settle`: ref·셀렉터 기반 조작, 안정화 후 diff 반환
- screenshot / 비디오 / 로그 / 성능·트레이스 수집
- batch: 여러 명령 일괄 실행, `.ad` 스크립트 저장·재생
- `agent-device help <mode>`: manual-qa, dogfood, validate, react-native, debugging 등 에이전트용 워크플로 가이드 내장
- MCP 서버 모드 지원 (CLI 직접 실행이 권장 방식)

## 공식 링크

- GitHub: https://github.com/callstack/agent-device
- npm: https://www.npmjs.com/package/agent-device

## 설치

Node.js 22.12+ 필요.

```bash
npm install -g agent-device@latest
agent-device doctor   # 환경 진단 (SDK, 기기, 러너 캐시)
```

플랫폼별 사전 요구사항은 기존과 동일하다 — Android는 Android Studio/SDK(에뮬레이터·adb), iOS는 Xcode(시뮬레이터·XCTest 러너). doctor가 누락 항목을 알려준다.

## 스킬 등록 (새 기기 세팅)

agent-device 자체는 npm CLI일 뿐 스킬이 아니다. Claude Code에서 `/agent-device` 및 "앱 테스트" 류 자연어로 트리거되게 하려면 얇은 SKILL.md 래퍼를 등록한다:

```bash
mkdir -p ~/.claude/skills/agent-device
# 아래 [부록 A] 내용을 ~/.claude/skills/agent-device/SKILL.md 로 저장
```

새 기기 전체 세팅은 3단계로 끝난다:

```bash
npm install -g agent-device@latest   # 1. 설치 (Node 22.12+)
agent-device doctor                  # 2. 진단
# 3. 부록 A → ~/.claude/skills/agent-device/SKILL.md 저장
```

설계 원칙: 스킬은 트리거·핵심 루프·규칙만 담고, 상세 워크플로는 CLI 내장 가이드(`agent-device help manual-qa` 등)에 위임한다. CLI가 업데이트돼도 스킬 파일을 고칠 일이 거의 없다.

### 자동 승인 (선택)

매 명령 승인이 귀찮으면 `~/.claude/settings.json`의 `permissions.allow`에 추가:

```json
"Bash(agent-device *)"
```

> ⚠️ Claude Code auto mode 분류기가 `~/.claude/settings.json` 직접 편집을 차단할 수 있으므로 사용자가 직접 편집한다 (android-qa-agent 시절과 동일한 제약).

## 기본 사용 루프

```bash
agent-device devices                 # 기기 확인
agent-device open <앱>               # 앱 실행 (세션 시작)
agent-device snapshot -i             # 접근성 스냅샷 → @e1, @e2 ... ref 획득
agent-device press @e10 --settle     # ref로 탭, 안정화 후 diff 반환
agent-device fill 'label="검색"' "hello" --settle
agent-device screenshot out.png
agent-device close
```

## 검증 이력 (2026-08)

- v0.20.3 설치, `doctor` 통과 (Vega CLI 미설치 경고만 — TV 개발 안 하면 무시)
- 연결된 Android 실기기(Galaxy A34) + AVD + iOS 시뮬레이터 29대 자동 인식
- iOS 시뮬레이터(iPhone 16)에서 open → snapshot(20노드) → press --settle(diff 정상) → screenshot → close 전체 루프 검증 완료
- 첫 iOS 실행 시 XCTest 러너 빌드로 스냅샷이 느림(~28초). doctor가 백그라운드로 캐시를 예열하며 이후 빨라진다.
- SKILL.md 래퍼 등록 후 Claude Code가 스킬로 인식하는 것 확인 (부록 A)

## 참고

- 부팅된 기기가 여러 개면 기본 타깃이 의도와 다를 수 있다. `--device`로 명시 지정.
- 셀렉터 키는 id, role, text, label, value 등만 지원. placeholder, index는 셀렉터가 아니다.
- `--settle`은 press/click/fill/longpress에만. open/snapshot/close에 붙이지 말 것.

## 부록 A: SKILL.md 템플릿

아래 내용을 `~/.claude/skills/agent-device/SKILL.md`로 저장하면 Claude Code에서 스킬로 인식된다.

`````markdown
---
name: agent-device
description: iOS/Android 시뮬레이터·에뮬레이터·실기기에서 앱을 자동으로 조작·검증하는 기기 자동화 에이전트. 접근성 스냅샷의 요소 ref로 탭/입력/스크린샷을 수행한다. Use when "앱 테스트", "기기 테스트", "시뮬레이터", "에뮬레이터", "device test", "mobile qa", "앱 QA", "ios test", "android test", "실기기"
---

# agent-device

Callstack의 크로스플랫폼 기기 자동화 CLI. 모든 조작은 Bash로 `agent-device` 명령을 직접 실행한다.

## 사전 확인

```bash
command -v agent-device || npm install -g agent-device@latest   # Node 22.12+
agent-device devices    # 기기 목록·부팅 상태 확인
```

문제 있으면 `agent-device doctor`로 진단.

## 핵심 루프 (inspect-act-verify)

```bash
agent-device open <앱>            # 세션 시작
agent-device snapshot -i          # 접근성 스냅샷 → @e1, @e2 ... ref 획득
agent-device press @e10 --settle  # ref로 조작, 안정화 후 변경 diff 반환
agent-device fill 'label="검색"' "텍스트" --settle
agent-device screenshot /tmp/shot.png
agent-device close                # 세션 종료 (필수)
```

## 규칙

- **좌표 추측 금지.** 반드시 snapshot의 ref(`@eN`) 또는 셀렉터(`role=button label="확인"`)로 조작한다.
- `--settle`은 press/click/fill/longpress에만 붙인다. open/snapshot/close에는 금지.
- `--settle`이 반환한 diff를 근거로 다음 행동을 정한다. diff가 있으면 snapshot 재캡처 불필요.
- 부팅된 기기가 여러 대면 `--device <이름>`으로 명시 지정 (실기기가 기본 타깃으로 잡힐 수 있음).
- 셀렉터 키는 id, role, text, label, value, editable, focused 등만. placeholder/index/key는 셀렉터가 아니다.
- 작업 종료 시 반드시 `agent-device close`.

## 상세 워크플로 (필요 시 CLI에서 직접 읽기)

```bash
agent-device help manual-qa       # 수동 테스트 스크립트 수행
agent-device help dogfood         # 탐색적 테스트 + 이슈 리포트
agent-device help validate        # 코드 변경 검증 (성능·비주얼·로그)
agent-device help react-native    # RN/Expo 앱 대상일 때
agent-device help debugging       # 로그·네트워크·성능·트레이스
agent-device help physical-device # 실기기 연결·iOS 서명
```
`````
