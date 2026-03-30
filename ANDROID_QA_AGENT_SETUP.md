# Android QA Agent 세팅 가이드

에뮬레이터에서 앱을 자동으로 테스트하기 위한 환경 세팅 가이드.
Claude Code가 ADB를 통해 Android 에뮬레이터를 직접 제어하고, 스크린샷을 캡처하여 테스트합니다.

마지막 세팅: 2026-03-29

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
java -version          # openjdk 21.x
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

## 6. android-qa-agent 클론

```bash
cd ~/Documents/projects/angie
git clone https://github.com/tobrun/android-qa-agent.git
cd android-qa-agent
chmod +x android-qa android-qa-replay start-recording stop-recording
```

### 위치
```
~/Documents/projects/angie/android-qa-agent/
```

---

## 7. APK 빌드 및 설치

### local.properties 확인
`angie-cart/android/local.properties` 파일에 SDK 경로가 있어야 합니다:
```
sdk.dir=/Users/kanghaeseok/Library/Android/sdk
```

없으면 생성:
```bash
echo "sdk.dir=$HOME/Library/Android/sdk" > ~/Documents/projects/angie/angie-cart/angie-cart/android/local.properties
```

### Release APK 빌드
```bash
cd ~/Documents/projects/angie/angie-cart/angie-cart/android
./gradlew assembleRelease -x lintVitalAnalyzeRelease -x lintVitalReportRelease
```

> **Metaspace OOM 발생 시**: `android/gradle.properties`의 메모리 설정 확인
> ```
> org.gradle.jvmargs=-Xmx4096m -XX:MaxMetaspaceSize=1024m
> ```

### APK 위치
```
android/app/build/outputs/apk/release/app-release.apk
```

### 에뮬레이터에 설치
```bash
adb install -r android/app/build/outputs/apk/release/app-release.apk
```

> **서명 충돌 시** (debug→release 전환 등):
> ```bash
> adb uninstall com.hotbloodturtle.angiecart
> adb install android/app/build/outputs/apk/release/app-release.apk
> ```

---

## 8. 앱 실행 및 스크린샷

### 앱 실행
```bash
adb shell am start -n com.hotbloodturtle.angiecart/.MainActivity
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

## 9. 빠른 시작 (이미 세팅된 환경)

모든 세팅이 완료된 후, 테스트를 시작하려면:

```bash
# 1. 에뮬레이터 실행
nohup emulator -avd test_device -no-window -no-audio -no-boot-anim -gpu swiftshader_indirect > /tmp/emulator.log 2>&1 &

# 2. 부팅 대기
adb wait-for-device && adb shell getprop sys.boot_completed

# 3. APK 빌드 + 설치
cd ~/Documents/projects/angie/angie-cart/angie-cart/android
./gradlew assembleRelease -x lintVitalAnalyzeRelease -x lintVitalReportRelease
adb install -r app/build/outputs/apk/release/app-release.apk

# 4. 앱 실행
adb shell am start -n com.hotbloodturtle.angiecart/.MainActivity

# 5. 스크린샷 확인
sleep 5 && adb exec-out screencap -p > /tmp/test.png
```

---

## 10. 트러블슈팅

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
adb uninstall com.hotbloodturtle.angiecart
adb install app-release.apk
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

### RevenueCat "Wrong API Key" 다이얼로그
Release 빌드에서 `test_` 키 사용 시 발생. `lib/iap/index.ts`의 `isIAPEnabled` 가드가 플레이스홀더 키일 때 자동으로 IAP를 건너뜀.

---

## 참고

- **android-qa-agent 리포**: https://github.com/tobrun/android-qa-agent
- **패키지명**: `com.hotbloodturtle.angiecart`
- **MainActivity**: `com.hotbloodturtle.angiecart/.MainActivity`
- **AVD 이름**: `test_device`
- **시스템 이미지**: `android-34;google_apis;arm64-v8a`
