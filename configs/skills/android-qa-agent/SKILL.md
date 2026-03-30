# Android QA Agent

Android 에뮬레이터/실기기에서 앱을 자동으로 테스트하는 QA 에이전트.
ADB를 통해 스크린샷, UI dump, 터치, 텍스트 입력 등을 수행한다.

Use when: "android qa", "앱 테스트", "에뮬레이터 테스트", "android test", "adb test", "앱 QA"

## 사전 요구사항
- Android 에뮬레이터 실행 중 또는 실기기 연결
- adb 사용 가능
- android-qa-agent 설치됨 (`which android-qa`로 확인)

## 도구 위치
```
QA_AGENT_DIR=~/Documents/projects/angie-projects/android-qa-agent
```

## 세션 시작 워크플로

### 1. 디바이스 확인
```bash
adb devices
```
- 0개 → "연결된 디바이스가 없습니다" 안내
- 1개 → 자동 선택
- 여러 개 → AskUserQuestion으로 사용자에게 선택 요청

### 2. 패키지 검색
사용자 프롬프트에서 앱 키워드를 추출하여:
```bash
adb shell pm list packages | grep <키워드>
```

### 3. 세션 시작
```bash
cd $QA_AGENT_DIR && ./start-recording <세션명> --prompt "<사용자 프롬프트>" --device <시리얼> --package <패키지명>
```

옵션 자동 감지:
- "성능", "fps", "프레임", "jank" → `--perf` 추가
- "트레이스", "perfetto", "systrace" → `--trace` 추가
- "초기화 안함", "데이터 유지", "warm start" → `--no-clear` 추가

## 핵심 원칙: 보기 → 분석 → 행동

**절대 스크린샷만 보고 탭하지 마라. 반드시 UI dump로 좌표를 확인한다.**

1. **스크린샷** — 화면 상태 파악
2. **UI dump** — XML에서 정확한 좌표 추출
3. **좌표 계산** — bounds `[left,top][right,bottom]`의 중앙점
4. **행동** — tap, type, swipe 등

## ADB 명령 (반드시 android-qa 래퍼 사용)

```bash
cd $QA_AGENT_DIR

# 스크린샷
S=$(python3 -c "import json;print(json.load(open('.android-qa/active-session.json'))['session_name'])") && \
F=artifacts/$S/screen-$(date -u +%Y%m%dT%H%M%S).png && mkdir -p "artifacts/$S" && \
./android-qa shell screencap -p /sdcard/screen.png && \
./android-qa pull /sdcard/screen.png "$F" && echo "$F"

# UI dump
S=$(python3 -c "import json;print(json.load(open('.android-qa/active-session.json'))['session_name'])") && \
F=artifacts/$S/dump-$(date -u +%Y%m%dT%H%M%S).xml && mkdir -p "artifacts/$S" && \
./android-qa shell uiautomator dump && \
./android-qa pull /sdcard/window_dump.xml "$F" && echo "$F"

# UI dump 파싱 (좌표 추출)
python3 -c "
import xml.etree.ElementTree as ET
tree = ET.parse('<dump파일.xml>')
for node in tree.iter():
    text = node.get('text', '')
    bounds = node.get('bounds', '')
    res = node.get('resource-id', '')
    if text or res:
        print(f'text={text!r} res={res} bounds={bounds}')
"

# 터치
./android-qa shell input tap <x> <y>

# 텍스트 입력
./android-qa shell input text "<텍스트>"

# 키 이벤트 (BACK=4, HOME=3, ENTER=66)
./android-qa shell input keyevent <코드>

# 스와이프 (아래로 스크롤 예시)
./android-qa shell input swipe 640 2400 640 800 500

# 앱 실행
./android-qa shell am start -n <패키지명>/<액티비티명>
```

> **중요:** 네비게이션 액션(tap, back, swipe) 후 UI dump 전에 `sleep 1` 필수.

## 세션 종료

```bash
cd $QA_AGENT_DIR && ./stop-recording
```

결과 보고: 녹화 파일 경로, 명령 수, 성능 지표(있는 경우), 트레이스 파일(있는 경우)
