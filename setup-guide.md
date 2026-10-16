# 새 기기 설정: Claude Code

이 저장소는 개인 AI 작업 환경을 재현하기 위한 문서 모음이다.

명령 검증 기준: 2026-09-08, macOS Apple Silicon. Linux/Windows는 아래 플랫폼 안내와 각 upstream 설치 문서를 함께 따른다. 해당 OS에서 직접 실행 검증했다는 의미는 아니다.

> **claude-mem 금지:** 설치하지 않는다. 이미 있는 기기는 [handoff.md](handoff.md) 절차로 제거한다.

## 진행 순서

1. 아래 공통 런타임과 Claude Code를 설치하고 로그인한다.
2. [Claude 설치 순서](readme.md#claude-code-설치-가이드)와 아래 공통 래퍼·MCP 절차로 구성한다.
3. 프로젝트 설치형 도구는 실제 작업 프로젝트에서 초기화한다. 이 문서 저장소를 샘플 앱으로 초기화하지 않는다.
4. 스킬 인식, MCP 연결, 실제 기능을 각각 확인하고 로컬 점검 기록을 남긴다.

## 공통 런타임과 플랫폼

| 환경 | 준비 방법 / 한계 |
|---|---|
| macOS | Homebrew, Git, Node, Python, uv, Bun. iOS QA에는 Xcode 필요 |
| Linux | 배포판 패키지 관리자와 각 도구 공식 설치 방법 사용. 브라우저·Pango 시스템 라이브러리 별도 설치. iOS 시뮬레이터 불가 |
| Windows + WSL2 | Bash 기반 gstack·tmux·claude-squad 작업은 WSL 내부에서 설치/실행. Windows와 WSL의 홈·로그인·설정을 별도 환경으로 취급 |
| Windows 네이티브 | Node/Python/uv 사용 가능. Spec Kit은 `--script ps`. Bash 가이드를 PowerShell에 그대로 붙여넣지 않는다. 기기 SDK 연결은 별도 점검 |

macOS 예시:

```bash
brew install node python@3.11 uv gh tmux
# Bun이 없으면 https://bun.sh/docs/installation 의 해당 OS 설치 방법 사용
node --version
python3 --version
uv --version
bun --version
```

Node는 agent-device 기준 22.12+를 준비한다. macOS에서는 `python3`가 여전히 시스템 3.9일 수 있다. SEO 설치 명령에만 아래 PATH를 지정하면 셸 전체 설정을 바꾸지 않아도 된다.

```bash
PATH="$(brew --prefix python@3.11)/libexec/bin:$PATH" python3 --version
```

Claude Code는 [공식 설치 문서](https://code.claude.com/docs/en/setup)를 따른다. 앱 설치와 CLI 설치는 별도로 확인한다.

```bash
claude --version
```

Claude 로그인, API 키, 선택적 외부 서비스 인증은 새 기기에서 다시 설정한다. 기존 기기의 인증 파일을 이 저장소에 복사하지 않는다.

## 경로 원칙

| 대상 | 경로 |
|---|---|
| 전역 개인 규칙 | `~/.claude/CLAUDE.md` |
| 프로젝트 규칙 | `CLAUDE.md` |
| 전역 독립 스킬 | `~/.claude/skills/<name>/SKILL.md` |
| 프로젝트 독립 스킬 | `.claude/skills/` |
| MCP 등록 | `claude mcp add ...` |
| 플러그인 캐시 | `~/.claude/plugins/cache/` |
| 독립 훅 | `settings.json`의 hooks 등 |
| 공유 원본/레퍼런스 | `~/.local/share/ai-tools/` 사용 가능 |

동일 스킬을 여러 탐색 경로에 중복 설치하지 않는다. 독립 체크아웃의 스킬은 복사하거나 심링크할 수 있다. 설치 전 기존 설정 파일을 홈 디렉토리 내 별도 백업 폴더에 보관하고, `settings.json` 전체를 새 예제로 덮어쓰지 않고 항목별로 병합한다.

## 이 저장소의 공통 래퍼

`skills/`에는 BMAD, Spec Kit, Codebase Memory, agent-device, Playwright CLI, Awesome Design, explain-diff의 짧은 스킬 원본이 있다. 별도 앱 코드가 아니라 기기 간 복원을 위한 지침이다.

이 저장소 루트에서 복사:

```bash
mkdir -p "$HOME/.claude/skills"
for skill in skills/*; do
  target="$HOME/.claude/skills/$(basename "$skill")"
  if [ -e "$target" ] || [ -L "$target" ]; then
    echo "기존 항목 유지: $target"
  else
    cp -R "$skill" "$target"
  fi
done
```

기존 explain-diff 슬래시 커맨드와 동일 이름의 스킬은 둘 중 하나를 선택한다. 업데이트 시에는 기존 파일과 diff를 확인해 복사한다. 복사 설치는 저장소 pull만으로 자동 갱신되지 않는다.

## MCP

이미 같은 서버가 등록됐는지 확인하고 없는 서버만 추가한다. 등록 명령은 [Claude 설치 순서](readme.md#4-mcp-서버)에 있다. Codebase Memory의 바이너리는 먼저 [설치](codebase-memory.md)해야 한다. GUI에서 PATH를 못 찾으면 `command -v codebase-memory-mcp`로 확인한 현재 기기의 절대 경로를 등록한다. 다른 기기의 사용자명·절대 경로를 복사하지 않는다. Task Master의 core 도구 연결 확인은 PRD 분해의 모델 인증 성공과 다르다. [Task Master](task-master.md)의 프로젝트별 provider 설정을 완료해야 한다.

모두 설치해도 매 작업에서 전부 실행하지 않는다. 사용자가 지정한 워크플로를 우선하고, 미지정이면 작업에 맞는 주 계획 도구 하나를 선택한다.

## 활성화와 사용 확인

설치 단계마다 다음을 구분한다.

| 단계 | 확인 내용 |
|---|---|
| 파일/설정 | 스킬의 SKILL.md, 플러그인 활성 설정, CLI 버전, MCP 등록 |
| 프로토콜/런타임 | MCP initialize + tools/list, 브라우저 열기/닫기, SEO 환경 진단, 기기 doctor |
| 작업 검증 | 실제 문서 생성, 대상 앱 조작, PRD 분해 등. 계정·대상 프로젝트가 있어야 확인 가능 |

새 세션에서 스킬을 확인한다. 플러그인·MCP 변경이 보이지 않으면 Claude Code를 재시작한다. `/hooks`에서 새 훅의 소스·명령을 확인한다. **설치했다고 훅이 자동 실행 검증된 것은 아니다.** 다량의 스킬을 설치하면 초기 설명이 축약될 수 있으므로 원하는 스킬을 이름으로 지정할 수 있다.

```bash
claude plugin list
claude mcp list
claude doctor
rtk --version
agent-device doctor
specify --version
```

MCP 설정·목록 출력에는 인자에 넣은 키가 표시될 수 있으므로 그대로 커밋하거나 공유하지 않는다. [점검 스크립트](scripts/check-setup.py)는 키/인자를 출력하지 않는 최상위 파일·등록 상태 요약용이다. 중첩 스킬이나 활성 로딩 결과, 연결 검증을 대신하지 않는다.

```bash
mkdir -p .local
python3.11 scripts/check-setup.py > .local/setup-check.json
```

## 업데이트·복구

- 개인 설치 결과·로그는 Git에서 제외한 `.local/`에 보관한다. 공용 문서에는 검증한 버전·명령·제약을 기록한다.
- 전역 설정/인증 파일은 커밋하지 않는다. 공용 저장소에는 키 없는 예제와 복원용 스킬 원본만 둔다.
- 독립 clone은 `git status` 확인 → `git pull --ff-only` → 도구 setup 재실행.
- 스킬·플러그인·훅 개수는 upstream 변경에 따라 달라진다. 문서에 적힌 숫자 대신 실제 설치 버전을 기준으로 확인한다.
- 설치 실패 시 기존 설정 백업과 비교하고 이번에 추가한 항목만 복구한다.
