# Android QA Agent 세팅 가이드

에뮬레이터에서 앱을 자동으로 테스트하기 위한 환경 세팅 가이드.
Claude Code가 ADB를 통해 Android 에뮬레이터를 직접 제어하고, 스크린샷을 캡처하여 테스트합니다.

마지막 세팅: 2026-03-30

---

## 전체 구조

```
Claude Code
    ↓ (자연어 프롬프트)
android-qa-agent (ADB 래퍼)
    ↓ (ADB 명령)
Android 에뮬레이터 (headless, -no-window)
    ↓
앱 조작 + 스크린샷 캡처
```

---

## 사전 요구사항

| 항목 | 확인 방법 |
|------|----------|
| Android Studio | 설치됨 |
| Java (JDK) | Android Studio 내장 JDK 사용 |
| Python 3.8+ | `python3 --version` |
| Claude Code | 현재 사용 중 |

---

## 1. 환경변수 설정

`~/.zshrc`에 아래 내용이 있어야 합니다:

```bash
export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
```

설정 후 적용:
```bash
source ~/.zshrc
```

### 확인
```bash
java -version          # openjdk 버전 확인
adb --version          # Android Debug Bridge
emulator -list-avds    # AVD 목록
```

---

## 2. Android SDK Command-line Tools 설치

cmdline-tools가 없으면 AVD를 CLI에서 생성할 수 없습니다.

### 방법 A: 직접 다운로드 (우리가 사용한 방법)

```bash
# 다운로드
cd /tmp
curl -O https://dl.google.com/android/repository/commandlinetools-mac-11076708_latest.zip

# 설치
mkdir -p ~/Library/Android/sdk/cmdline-tools
unzip -q -o commandlinetools-mac-11076708_latest.zip -d /tmp/cmdline-extract
mv /tmp/cmdline-extract/cmdline-tools ~/Library/Android/sdk/cmdline-tools/latest

# 확인
sdkmanager --version
avdmanager list avd
```

### 방법 B: Android Studio에서 설치

Android Studio → Settings → Languages & Frameworks → Android SDK → SDK Tools 탭 → "Android SDK Command-line Tools" 체크 → Apply

---

## 3. 시스템 이미지 다운로드

에뮬레이터에 설치할 Android OS 이미지입니다.

```bash
# Android 34 (ARM64, Google APIs) 설치
yes | sdkmanager "system-images;android-34;google_apis;arm64-v8a"
```

> **참고**: Mac Apple Silicon(M1/M2/M3/M4)은 `arm64-v8a`를 사용합니다.
> Intel Mac이면 `x86_64`로 교체하세요.

### 확인
```bash
ls ~/Library/Android/sdk/system-images/android-34/google_apis/arm64-v8a/
```

---

## 4. AVD (가상 기기) 생성

```bash
echo "no" | avdmanager create avd \
  -n test_device \
  -k "system-images;android-34;google_apis;arm64-v8a" \
  -d pixel_6 \
  --force
```

### 확인
```bash
emulator -list-avds
# 출력: test_device
```

### AVD 삭제 (필요 시)
```bash
avdmanager delete avd -n test_device
```

---

## 5. 에뮬레이터 실행 (Headless)

GUI 없이 백그라운드에서 에뮬레이터를 실행합니다.

```bash
nohup emulator -avd test_device \
  -no-window \
  -no-audio \
  -no-boot-anim \
  -gpu swiftshader_indirect \
  > /tmp/emulator.log 2>&1 &
```

### 부팅 완료 대기
```bash
adb wait-for-device
adb shell getprop sys.boot_completed
# 출력: 1 이면 부팅 완료
```

### 에뮬레이터 종료
```bash
adb emu kill
```

### 연결 확인
```bash
adb devices
# 출력: emulator-5554  device
```

---

## 6. android-qa-agent 설치

```bash
# 클론
cd ~/Documents/projects/angie-projects
git clone https://github.com/tobrun/android-qa-agent.git
cd android-qa-agent
chmod +x android-qa android-qa-replay start-recording stop-recording

# 전역 사용을 위한 심링크 등록
mkdir -p ~/.local/bin
ln -sf "$(pwd)/android-qa" ~/.local/bin/android-qa
ln -sf "$(pwd)/android-qa-replay" ~/.local/bin/android-qa-replay
ln -sf "$(pwd)/start-recording" ~/.local/bin/start-recording
ln -sf "$(pwd)/stop-recording" ~/.local/bin/stop-recording
```

> `~/.local/bin`이 PATH에 포함되어 있어야 합니다. 없으면 `~/.zshrc`에 추가:
> ```bash
> export PATH="$HOME/.local/bin:$PATH"
> ```

### 확인
```bash
which android-qa       # ~/.local/bin/android-qa
android-qa             # "no active recording session" 메시지가 나오면 정상
```

### 위치
```
~/Documents/projects/angie-projects/android-qa-agent/
```

### Claude Code 스킬 등록

`~/.claude/skills/android-qa-agent/SKILL.md`에 스킬 파일을 생성하면 Claude Code에서 `/android-qa-agent`로 호출할 수 있습니다. 이 가이드 하단의 [부록 A: SKILL.md 템플릿](#부록-a-skillmd-템플릿)을 참고해 수동으로 생성하세요.

### 자동 승인 설정

Android QA 관련 명령어를 매번 수동 승인하지 않으려면 `~/.claude/settings.json`의 `permissions.allow`에 아래 패턴을 추가합니다:

```json
"Bash(adb *)",
"Bash(QA_DIR=*)",
"Bash(cd */android-qa-agent*)",
"Bash(*/android-qa *)",
"Bash(*/emulator *)",
"Bash(emulator *)",
"Bash(*/start-recording *)",
"Bash(*/stop-recording*)",
"Bash(sleep *)",
"Bash(for *)",
"Bash(lsof *)"
```

---

## 7. APK 설치 및 앱 실행

### APK 에뮬레이터에 설치
```bash
adb install -r <앱.apk 경로>
```

> **서명 충돌 시** (debug→release 전환 등):
> ```bash
> adb uninstall <패키지명>
> adb install <앱.apk 경로>
> ```

### 앱 실행
```bash
adb shell am start -n <패키지명>/<액티비티명>
```

### 스크린샷 캡처
```bash
adb exec-out screencap -p > /tmp/screenshot.png
```

### UI dump (터치 좌표 계산용)
```bash
adb shell uiautomator dump /sdcard/ui-dump.xml
adb pull /sdcard/ui-dump.xml /tmp/ui-dump.xml
```

### 터치
```bash
adb shell input tap <x> <y>
```

### 텍스트 입력
```bash
adb shell input text "hello"
```

### 뒤로가기
```bash
adb shell input keyevent KEYCODE_BACK
```

---

## 8. 빠른 시작 (이미 세팅된 환경)

모든 세팅이 완료된 후, 테스트를 시작하려면:

```bash
# 1. 에뮬레이터 실행 (AVD 이름은 emulator -list-avds로 확인)
nohup emulator -avd <AVD_이름> -no-window -no-audio -no-boot-anim -gpu swiftshader_indirect > /tmp/emulator.log 2>&1 &

# 2. 부팅 대기
adb wait-for-device && adb shell getprop sys.boot_completed

# 3. APK 설치
adb install -r <앱.apk 경로>

# 4. 앱 실행
adb shell am start -n <패키지명>/<액티비티명>

# 5. 스크린샷 확인
sleep 5 && adb exec-out screencap -p > /tmp/test.png
```

---

## 9. 트러블슈팅

### "SDK location not found"
```bash
echo "sdk.dir=$HOME/Library/Android/sdk" > android/local.properties
```

### "Unable to locate a Java Runtime"
```bash
export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
```

### "INSTALL_FAILED_UPDATE_INCOMPATIBLE"
서명이 다른 APK로 교체할 때 발생:
```bash
adb uninstall <패키지명>
adb install <앱.apk>
```

### "OutOfMemoryError: Metaspace"
`android/gradle.properties` 수정:
```
org.gradle.jvmargs=-Xmx4096m -XX:MaxMetaspaceSize=1024m
```

### 에뮬레이터가 안 뜸
```bash
# 로그 확인
cat /tmp/emulator.log

# 프로세스 확인
ps aux | grep emulator

# 강제 종료 후 재시작
adb emu kill
```

---

## 참고

- **android-qa-agent 리포**: https://github.com/tobrun/android-qa-agent
- **시스템 이미지 예시**: `android-34;google_apis;arm64-v8a`

---

## 부록 A: SKILL.md 템플릿

아래 내용을 `~/.claude/skills/android-qa-agent/SKILL.md`로 저장하면 Claude Code에서 `/android-qa-agent` 스킬로 호출할 수 있습니다.

````markdown
---
name: android-qa-agent
description: Android 에뮬레이터/실기기에서 앱을 자동으로 테스트하는 QA 에이전트. ADB를 통해 스크린샷, UI dump, 터치, 텍스트 입력을 수행한다. Use when "android qa", "앱 테스트", "에뮬레이터 테스트", "android test", "adb test", "앱 QA"
---

# Android QA Agent

Android 에뮬레이터/실기기에서 앱을 자동으로 테스트하는 QA 에이전트.
ADB를 통해 스크린샷, UI dump, 터치, 텍스트 입력 등을 수행한다.

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
- 여러 개 → 사용자에게 선택 요청

### 2. 패키지 검색
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

1. 스크린샷 — 화면 상태 파악
2. UI dump — XML에서 정확한 좌표 추출
3. 좌표 계산 — bounds `[left,top][right,bottom]`의 중앙점
4. 행동 — tap, type, swipe 등

> 네비게이션 액션(tap, back, swipe) 후 UI dump 전에 `sleep 1` 필수.

## 세션 종료

```bash
cd $QA_AGENT_DIR && ./stop-recording
```
````

전체 명령 예시와 고급 옵션은 [android-qa-agent 공식 README](https://github.com/tobrun/android-qa-agent)를 참고하세요.
