# Codex 완전 셋업 마스터 가이드

> 개인용 macOS 기준. 설치 우선, 운영 보조.
>
> 최종 업데이트: 2026-03-31

---

## 목차

- [개념 정리](#개념-정리)
- [무엇이 그대로 되고 무엇이 달라지는가](#무엇이-그대로-되고-무엇이-달라지는가)
- [빠른 설치 가이드](#빠른-설치-가이드)
- [상세 설치 가이드](#상세-설치-가이드)
- [검증 가이드](#검증-가이드)
- [개인 운영 프로필](#개인-운영-프로필)
- [추천 조합](#추천-조합)
- [트러블슈팅](#트러블슈팅)
- [공식/로컬 참고 링크](#공식로컬-참고-링크)

---

## 개념 정리

Claude Code 문서를 Codex로 옮길 때는 이름보다 역할을 기준으로 다시 잡아야 합니다.

| 개념 | Codex에서의 역할 | 현재 문서에서의 위치 |
|------|------------------|----------------------|
| **Codex CLI** | 메인 실행기. 대화형 세션, 비대화형 실행, 리뷰, MCP 관리 | 설치/검증 |
| **`AGENTS.md`** | 프로젝트별 작업 규칙. 탐색 우선순위, 금지 사항, 검증 기준 | 상세 설치 / 운영 |
| **Skill** | 반복 작업 워크플로. 스킬 파일(`SKILL.md`) 기반 | 상세 설치 |
| **MCP** | 외부 도구 연결. DB, 브라우저, 문서, Figma, Sentry 등 | 상세 설치 |
| **`config.toml`** | 기본 모델, 추론 강도, trust, MCP 등록 | 상세 설치 |
| **Subagent** | 병렬 탐색, 리뷰, 구현 분리 | 운영 원칙 |
| **Plugin** | 고급/로컬 확장 패키징. Codex에서는 설치 UX보다 구조 설계 쪽이 중요 | 개념 설명만 |
| **`codex exec` / `review`** | 비대화형 자동화, 리뷰 루프 | 상세 설치 / 검증 |

### 현재 로컬 환경에서 확인된 사실

- `codex` CLI가 설치되어 있음
- `codex mcp` 하위 명령으로 MCP를 직접 관리할 수 있음
- `~/.codex/config.toml`에서 모델, trust, MCP 서버를 관리 중
- `~/.codex/skills/.system/`에 시스템 스킬이 존재함
- `~/.codex/superpowers/skills/`에 Superpowers 스킬 세트를 따로 보관 중
- `playwright-cli`, `rtk`, `uv`가 로컬에 설치되어 있음

---

## 무엇이 그대로 되고 무엇이 달라지는가

Claude Code 개념을 Codex에 그대로 복사하면 오해가 생깁니다. 아래 표처럼 분리해서 보는 편이 정확합니다.

| Claude 개념 | Codex 대응 | 상태 | 메모 |
|-------------|------------|------|------|
| `Skill` | `SKILL.md` 기반 스킬 | **그대로 가능** | 시스템 스킬 + 로컬 스킬 구조 유지 가능 |
| `MCP` | `codex mcp add/list/get/remove` | **그대로 가능** | 운영 방식이 거의 동일 |
| `AGENTS.md`/규칙 | `AGENTS.md` | **그대로 가능** | Codex 쪽에서 더 핵심적임 |
| `settings.json` 중심 제어 | `config.toml` + `AGENTS.md` + 승인 정책 | **부분 가능** | 파일 구조와 제어 지점이 다름 |
| 플랜 모드 | 명시적 계획 수립, `update_plan`, 설계/플랜 문서 | **부분 가능** | 동일한 UI 개념보다 작업 방식으로 재해석 |
| 슬래시 명령 중심 운용 | CLI 명령 + 스킬 + 세션 지시 | **부분 가능** | 문서 본문은 CLI/파일 중심으로 작성 |
| Plugin Marketplace | 로컬 플러그인 구조/패키징 | **재해석 필요** | Claude처럼 마켓플레이스 설치가 중심이 아님 |
| RTK 자동 훅 재작성 | 직접 `rtk <cmd>` 사용 또는 별도 래핑 | **부분 가능** | 현재 Codex의 훅 개념은 안정적 기본값이 아님 |
| `frontend-design` 스킬 | 커스텀 스킬 또는 `AGENTS.md` 스타일 규칙 | **재해석 필요** | 현재 기본 제공으로 가정하면 안 됨 |
| `serena` 플러그인 | 별도 이식 또는 다른 시맨틱 도구 사용 | **재해석 필요** | 현재 환경에서는 `codebase-memory-mcp`가 더 현실적 |

### 추천 해석

- **먼저 잡을 것:** `Codex CLI`, `config.toml`, `AGENTS.md`, `MCP`, `skills`
- **그다음 붙일 것:** `Playwright CLI`, `android-qa-agent`, `RTK`
- **마지막에 고민할 것:** 로컬 plugin 패키징, Claude 전용 스킬의 이식

---

## 빠른 설치 가이드

### 전제 조건

| 항목 | 권장 | 확인 명령어 |
|------|------|------------|
| macOS | Apple Silicon + 최신 Ventura/Sonoma 계열 | `sw_vers` |
| Homebrew | 최신 | `brew --version` |
| Git | 최신 | `git --version` |
| Node.js | 22+ 권장 | `node -v` |
| Python | 3.10+ 권장 | `python3 --version` |
| uv | Python 기반 도구 보조용 | `uv --version` |
| jq | JSON/스크립트 보조용 | `jq --version` |
| ripgrep | 빠른 검색 | `rg --version` |

### 1단계: Codex CLI 설치

이 단계는 **현재 로컬 머신을 같은 방식으로 복원할 때 쓰는 예시**입니다. Codex의 공식 기본 설치법이라고 단정하지 말고, OpenAI 공식 Codex 문서를 항상 우선 확인하세요.

```bash
brew install --cask codex
codex --version
```

> 참고:
> - 현재 머신의 `codex` 바이너리는 `/opt/homebrew/Caskroom/codex/...`를 가리키고 있습니다.
> - 따라서 위 명령은 `내 로컬 복원용` 예시입니다.
> - 새 환경에서는 먼저 OpenAI 공식 Codex 문서의 최신 설치 절차를 확인하세요.

### 2단계: 로그인

```bash
codex login
```

로그인 후 기본 동작 확인:

```bash
codex --help
codex exec --help
codex review --help
codex mcp --help
```

### 3단계: 필수 보조 도구 설치

```bash
brew install jq uv ripgrep rtk
npm install -g @playwright/cli@latest
```

확인:

```bash
rtk --version
uv --version
playwright-cli --help
```

### 4단계: 기본 설정 파일 준비

```bash
mkdir -p ~/.codex/skills
test -f ~/.codex/config.toml || touch ~/.codex/config.toml
```

### 5단계: 프로젝트별 규칙 파일 준비

프로젝트 루트에 `AGENTS.md`를 둡니다.

```bash
cd /path/to/project
touch AGENTS.md
```

### 6단계: 필수 MCP 추가

최소 추천 세트:

```bash
codex mcp add context7 -- npx -y @upstash/context7-mcp@latest
codex mcp add filesystem -- npx -y @modelcontextprotocol/server-filesystem /Users/$USER/Documents/projects
codex mcp add playwright -- npx @playwright/mcp@latest
codex mcp add sequential-thinking -- npx -y @modelcontextprotocol/server-sequential-thinking
```

선택 추천:

```bash
codex mcp add codebase-memory-mcp -- /Users/$USER/.local/bin/codebase-memory-mcp
```

확인:

```bash
codex mcp list
```

### 7단계: 첫 검증

```bash
codex features list
find ~/.codex/skills -maxdepth 3 -name SKILL.md | sort
find ~/.codex/superpowers/skills -maxdepth 2 -name SKILL.md | sort
```

---

## 상세 설치 가이드

### 1. `config.toml` 기본 구조

Codex의 중심 설정은 `~/.codex/config.toml`입니다.

현재 개인용 기본값으로 추천하는 방향:

- 모델: `gpt-5.4`
- 추론 강도: `high` 또는 `xhigh`
- 성격: `pragmatic`
- 자주 쓰는 프로젝트는 `trusted`
- MCP는 여기서 관리

예시:

```toml
model = "gpt-5.4"
model_reasoning_effort = "xhigh"
personality = "pragmatic"

[projects."/Users/you/Documents/projects/example"]
trust_level = "trusted"

[mcp_servers.context7]
command = "npx"
args = ["-y", "@upstash/context7-mcp@latest"]

[mcp_servers.filesystem]
command = "npx"
args = [
  "-y",
  "@modelcontextprotocol/server-filesystem",
  "/Users/you/Documents/projects"
]

[mcp_servers.playwright]
command = "npx"
args = ["@playwright/mcp@latest"]

[mcp_servers.sequential-thinking]
command = "npx"
args = ["-y", "@modelcontextprotocol/server-sequential-thinking"]

[mcp_servers.codebase-memory-mcp]
command = "/Users/you/.local/bin/codebase-memory-mcp"
```

### 중요한 보안 주의사항

- `config.toml`은 **개인 로컬 설정 파일**입니다.
- `codex mcp add`로 추가한 stdio 서버 인자나 env 값이 **평문으로 남을 수 있습니다**.
- 따라서 API 키, 액세스 토큰, DB 연결 문자열이 들어가는 MCP는 다음 원칙을 지키세요.

1. 절대 이 파일을 Git에 커밋하지 않는다.
2. 화면 공유나 스크린샷 전에 민감값을 가린다.
3. 팀 문서에는 실제 값을 적지 않고 placeholder만 남긴다.

### 2. 프로젝트 trust 설정

자주 여는 프로젝트는 trusted로 등록합니다.

```toml
[projects."/Users/you/Documents/projects/my-project"]
trust_level = "trusted"
```

권장 기준:

- **trusted**: 본인이 직접 관리하는 프로젝트, 자주 쓰는 리포
- **기본값 유지**: 외부 코드, 검토용 리포, 실험용 다운로드 폴더

### 3. `AGENTS.md`를 프로젝트 계약서로 사용

Codex에서는 `AGENTS.md`가 매우 중요합니다. `settings.json` 중심이었던 습관보다 더 효과적입니다.

최소 템플릿:

```markdown
# Project Contract

## Commands
- install:
- dev:
- test:
- lint:
- build:

## Boundaries
- api:
- domain:
- ui:

## Safety
- never edit:
- always run:
- ask before:

## Verification
- unit:
- integration:
- visual:
```

개인용 확장 예시:

```markdown
## Working Style
- plan first
- prefer MCP tools before grep when available
- use subagents when tasks can be split cleanly
- run thorough verification before claiming completion
- for web tasks, prefer playwright-cli first and Playwright MCP second
- ask before android-qa-agent app runs
```

### 4. Skills 설치와 운영

### 시스템 스킬

현재 로컬에서 확인된 시스템 스킬:

- `openai-docs`
- `plugin-creator`
- `skill-creator`
- `skill-installer`
- `imagegen`

> 참고: 시스템 스킬 목록은 Codex 버전에 따라 달라질 수 있습니다.

위치는 보통 아래 구조입니다.

```bash
~/.codex/skills/.system/
```

### 사용자 스킬

직접 설치하는 스킬은 아래 위치에 둡니다.

```bash
~/.codex/skills/<skill-name>/SKILL.md
```

### Superpowers

현재 개인 환경은 Superpowers를 아래에 따로 두고 있습니다.

```bash
~/.codex/superpowers/skills/
```

확인된 스킬:

- `brainstorming`
- `writing-plans`
- `executing-plans`
- `test-driven-development`
- `systematic-debugging`
- `subagent-driven-development`
- `dispatching-parallel-agents`
- `requesting-code-review`
- `verification-before-completion`
- 그 외 다수

보관 경로 예시:

```bash
git clone https://github.com/obra/superpowers.git ~/.codex/superpowers
find ~/.codex/superpowers/skills -maxdepth 2 -name SKILL.md | sort
```

> 주의:
> - 현재 이 저장소/환경에서는 Superpowers가 작업 규칙에 깊게 연결되어 있습니다.
> - 일반 Codex 기본 설치만으로 이 경로가 자동 활성화된다고 가정하면 안 됩니다.
> - 즉, `git clone`만으로 끝나는 설치 문서가 아니라 `어떻게 참조하게 만들 것인가`까지 함께 맞춰야 합니다.
> - 본인 환경에서 쓰려면 경로를 고정하고, 개인 운영 규칙이나 글로벌 지시문에서 참조되도록 맞추는 편이 현실적입니다.

### `frontend-design`과 `serena`에 대한 현실적 정리

- `frontend-design`
  - Claude 쪽에서는 잘 알려진 스킬/플러그인 조합이지만, 현재 Codex 기본 스킬로 확인되지는 않았습니다.
  - 필요하면 별도 커스텀 스킬로 이식하거나, 디자인 규칙을 `AGENTS.md`에 직접 적는 편이 안전합니다.

- `serena`
  - 현재 이 Codex 환경에선 기본 MCP나 기본 스킬로 확인되지 않았습니다.
  - 시맨틱 코드 탐색이 필요하면 현재는 `codebase-memory-mcp` + 기본 코드 탐색 흐름이 더 현실적입니다.

### 5. MCP 설치 전략

개인용 Codex 환경에서 추천하는 MCP 우선순위:

| 우선순위 | 서버 | 용도 |
|----------|------|------|
| 1 | `filesystem` | 로컬 파일 접근 |
| 1 | `context7` | 최신 라이브러리 문서 |
| 1 | `playwright` | 브라우저 자동화 |
| 1 | `sequential-thinking` | 복잡한 사고 정리 |
| 2 | `codebase-memory-mcp` | 시맨틱 코드 탐색 |
| 2 | `figma` | 디자인/에셋 |
| 2 | `postgresql` / `supabase` | DB 작업 |
| 2 | `sentry` | 장애/이슈 분석 |
| 2 | `asana` | 작업 관리 |

### 실제 등록 형태

Codex CLI는 두 가지 방식으로 MCP를 추가합니다.

1. **stdio 서버**

```bash
codex mcp add context7 -- npx -y @upstash/context7-mcp@latest
```

2. **streamable HTTP 서버**

```bash
codex mcp add openaiDeveloperDocs --url https://developers.openai.com/mcp
```

`codex mcp add --help` 기준 핵심 옵션:

- `--url`
- `--env KEY=VALUE`
- `--bearer-token-env-var ENV_VAR`
- `-- <COMMAND>...`

### 권장 MCP 세트 예시

```bash
codex mcp add context7 -- npx -y @upstash/context7-mcp@latest
codex mcp add filesystem -- npx -y @modelcontextprotocol/server-filesystem /Users/$USER/Documents/projects
codex mcp add playwright -- npx @playwright/mcp@latest
codex mcp add sequential-thinking -- npx -y @modelcontextprotocol/server-sequential-thinking
codex mcp add codebase-memory-mcp -- /Users/$USER/.local/bin/codebase-memory-mcp
```

### 디자인/DB/운영형 MCP 예시

```bash
codex mcp add figma -- npx -y figma-developer-mcp --stdio
codex mcp add sentry -- npx -y @sentry/mcp-server@latest
codex mcp add asana -- npx -y @roychri/mcp-server-asana
```

> 보안 메모:
> - 위 명령은 **패키지 형태 예시**입니다. 실제 사용 시에는 각 서버가 요구하는 인증 방식과 추가 인자를 따로 확인해야 합니다.
> - 실제 토큰/연결 문자열은 개인 로컬에서만 관리하세요.
> - 가능하면 토큰을 CLI 인자에 직접 넣지 말고, 서버별 권장 인증 방식을 먼저 확인하세요.
> - 특히 DB 연결 문자열을 **쉘 명령 인자에 직접 넣는 습관은 권장하지 않습니다**. 쉘 히스토리, 프로세스 목록, 공유 로그에 남기기 쉽습니다.
> - DB 계열 MCP는 `config.toml`을 로컬에서 직접 편집하되, 그 파일 역시 절대 커밋하지 않는 방식이 더 안전합니다.

### 6. 브라우저 자동화: `playwright-cli` 우선

웹 작업은 아래 우선순위를 권장합니다.

1. `playwright-cli`
2. Playwright MCP

이유:

- 빠르게 브라우저 상태를 확인하기 쉽다.
- 로컬 디버깅 명령이 직관적이다.
- 설치/검증 문서에 넣기 좋다.

설치:

```bash
npm install -g @playwright/cli@latest
playwright-cli --help
```

현재 로컬에서 확인된 대표 명령:

- `open`
- `snapshot`
- `click`
- `fill`
- `screenshot`
- `console`
- `network`
- `run-code`
- `state-save`

권장 사용 흐름:

```bash
playwright-cli open https://example.com
playwright-cli snapshot
playwright-cli click e3
playwright-cli fill e5 "user@example.com"
playwright-cli screenshot
playwright-cli close
```

### 7. 앱 테스트: `android-qa-agent`는 승인 후

앱 테스트는 별도 도구와 승인 절차를 둡니다.

- 웹: 기본적으로 바로 자동화 가능
- 앱: `android-qa-agent` 사용 전 승인 필요

이 저장소에는 별도 세팅 문서가 있습니다.

- `ANDROID_QA_AGENT_SETUP.md`

권장 규칙:

```markdown
- ask before android-qa-agent app runs
- prefer browser verification first when task is reproducible on web
```

### 8. RTK는 직접 사용 기준으로 정리

`RTK`는 설치 가치가 높지만, Claude 문서처럼 자동 PreToolUse 재작성까지 전제하면 위험합니다.

현재 Codex에서 현실적으로 추천하는 방식:

```bash
rtk git status
rtk git diff
rtk pytest -q
rtk npm test
```

권장 해석:

- **설치:** 한다
- **직접 실행:** 적극 추천
- **Codex 자동 훅 재작성:** 현재 기본 전제로 문서화하지 않는다

이유:

- 현재 `codex features list`에서 `codex_hooks`는 기본 활성 상태가 아니다.
- 따라서 RTK를 Claude와 같은 자동 훅 패턴으로 설명하면 문서가 과장된다.

### 9. 고급 사용: 비대화형 실행과 복귀

현재 로컬 CLI 도움말 기준 핵심 명령:

- `codex exec`
- `codex review`
- `codex resume`
- `codex fork`
- `codex mcp`
- `codex features`

예시:

```bash
codex exec "Read AGENTS.md and summarize the required verification steps."
codex review --uncommitted
codex resume --last
codex fork --last
```

### 언제 쓰는가

- `exec`: 반복형 자동화, CI 비슷한 비대화형 실행
- `review`: 변경사항 리뷰
- `resume`: 이전 세션 이어받기
- `fork`: 이전 세션 문맥을 분기해서 다른 접근 시도

### 10. Plugin은 마지막에

현재 확인 가능한 범위에서는, Codex에 **로컬 플러그인 패키징에 가까운 구조 단서**가 보입니다. 다만 이것을 설치 초반의 코어 기능처럼 다루면 과장입니다.

추가로 현재 로컬 `codex features list`에서는 `plugins`가 `stable true`로 보입니다. 그래도 이 문서는 **검증된 개인 셋업 기준**으로 쓰므로, 플러그인은 여전히 고급 주제로 뒤로 미룹니다.

문서화 기준:

- **먼저:** `AGENTS.md`, `skills`, `MCP`
- **나중:** 로컬 plugin 패키징

현재 로컬에서 확인된 구조 힌트:

- 플러그인 manifest: `.codex-plugin/plugin.json`
- 마켓플레이스 메타데이터: `.agents/plugins/marketplace.json`

이건 설치 초반에 잡을 항목이 아니라, 환경이 안정된 뒤 로컬 확장을 패키징할 때 다루는 게 맞습니다.

---

## 검증 가이드

설치는 버전 확인만 하고 끝내면 안 됩니다. 정적 검증과 행동 검증을 분리해서 봐야 합니다.

### 1. 정적 검증

### Codex CLI

```bash
codex --version
codex --help | sed -n '1,80p'
codex exec --help | sed -n '1,80p'
codex review --help | sed -n '1,80p'
codex mcp --help | sed -n '1,80p'
codex features list | sed -n '1,80p'
```

기대 결과:

- `exec`, `review`, `mcp`, `resume`, `fork`가 보인다.
- `features list`가 정상 동작한다.

### 설정 파일

```bash
test -f ~/.codex/config.toml && echo "config ok"
rg -n "trust_level|model|mcp_servers" ~/.codex/config.toml
```

### Skills

```bash
find ~/.codex/skills -maxdepth 3 -name SKILL.md | sort
find ~/.codex/superpowers/skills -maxdepth 2 -name SKILL.md | sort
```

### MCP

```bash
codex mcp list
codex mcp get context7
```

> 주의: `codex mcp list` 출력에는 민감값이 드러날 수 있으니 공유 전 가리세요.

### 실사용 검증 예시

등록 여부 확인과 실제 동작 확인은 다릅니다. 아래처럼 **실제 호출 예시**도 따로 돌리는 편이 안전합니다.

```bash
codex exec "Use the filesystem tool to read ./AGENTS.md and summarize the first three actionable rules."
codex exec "Use the Context7 docs tool to summarize the latest React useEffectEvent guidance."
playwright-cli open https://example.com
playwright-cli snapshot
playwright-cli close
```

기대 결과:

- `filesystem` 기반 읽기 결과가 나온다.
- `context7` 문서 질의가 실제로 동작한다.
- 브라우저가 열리고 스냅샷이 생성된다.

### 보조 도구

```bash
rtk --version
uv --version
playwright-cli --help | sed -n '1,80p'
```

### 2. 행동 검증

정적 검증이 끝나면 실제로 Codex가 의도대로 움직이는지 확인합니다.

### 시나리오 A: `AGENTS.md` 반영 확인

1. 테스트용 리포에 `AGENTS.md`를 둔다.
2. 특정 탐색 규칙이나 금지 사항을 적는다.
3. Codex에 간단한 작업을 요청한다.
4. 응답과 도구 사용 방식이 그 규칙을 따르는지 본다.

### 시나리오 B: MCP 인식 확인

1. Codex 세션을 연다.
2. 문서/라이브러리/브라우저 관련 작업을 요청한다.
3. `context7`, `filesystem`, `playwright`, `codebase-memory-mcp`가 실제로 사용되는지 확인한다.

### 시나리오 C: 병렬 에이전트 확인

1. 독립 태스크 2개를 준다.
2. Codex가 서브에이전트 분리를 제안/실행하는지 본다.
3. 결과 통합이 깔끔한지 본다.

### 시나리오 D: 웹 검증 확인

1. 웹 UI가 있는 프로젝트에서 작업을 준다.
2. `playwright-cli --help` 수준의 기초 점검 후 브라우저 검증을 수행하는지 본다.
3. 단순 스모크 테스트가 아니라 상호작용과 결과 확인까지 하는지 본다.

### 시나리오 E: 앱 테스트 승인 확인

1. 앱 테스트 작업을 준다.
2. `android-qa-agent`가 필요한 경우 먼저 승인 의사를 묻는지 본다.

---

## 개인 운영 프로필

아래 블록은 이 환경의 개인 기본 원칙으로 두기 좋습니다. `AGENTS.md` 또는 개인 메모에 넣고 반복 재사용하면 됩니다.

```markdown
## Personal Codex Operating Profile

- always plan first
- use every relevant tool available for the task
- use MCP, skills, local tooling, and subagents aggressively when they help
- if the task can be split cleanly, parallelize it
- correctness and completeness are more important than speed or token savings
- do not stop at smoke tests when deeper verification is practical
- for web tasks, inspect `playwright-cli --help` first and use browser testing
- use Playwright MCP as secondary option when CLI is not enough
- for app tasks, ask before running android-qa-agent
- compare alternatives coldly and choose based on evidence
- keep secrets out of repo files and out of shared screenshots
```

### 한국어 버전

- 항상 계획부터 세운다.
- 작업에 도움이 되는 도구는 적극적으로 다 쓴다.
- MCP, skills, 로컬 도구, 서브에이전트를 아끼지 않는다.
- 작업을 독립적으로 쪼갤 수 있으면 병렬화한다.
- 속도보다 정확성과 누락 없는 구현을 우선한다.
- 가능하면 스모크 테스트로 끝내지 않고 깊게 검증한다.
- 웹 작업은 `playwright-cli`를 먼저 보고 브라우저 테스트를 수행한다.
- CLI가 부족할 때 Playwright MCP를 차선으로 쓴다.
- 앱 테스트는 `android-qa-agent` 실행 전에 승인부터 받는다.
- 감으로 결정하지 않고 비교와 근거를 남긴다.

### `AGENTS.md`에 바로 넣기 좋은 문장

```markdown
## Working Rules
- plan before implementation
- use all relevant tools available in the environment
- prefer parallel subagents for independent tasks
- verify thoroughly before claiming completion
- for web tasks, use playwright-cli first and Playwright MCP second
- ask before android-qa-agent runs
```

---

## 추천 조합

### 1. 기본 코딩 세트

- `Codex CLI`
- `AGENTS.md`
- `config.toml`
- `filesystem` MCP
- `context7` MCP
- `sequential-thinking` MCP
- `Superpowers`

### 2. 시맨틱 코드 탐색 세트

- 기본 코딩 세트
- `codebase-memory-mcp`
- 프로젝트별 탐색 규칙이 적힌 `AGENTS.md`

> 현재 개인 환경에서는 `serena`보다 이 조합이 더 현실적입니다.

### 3. 프론트엔드/웹 세트

- 기본 코딩 세트
- `playwright-cli`
- Playwright MCP
- Figma MCP
- `frontend-design`에 해당하는 커스텀 규칙 또는 스킬

### 4. 데이터/백엔드/운영 세트

- 기본 코딩 세트
- PostgreSQL MCP
- Supabase MCP
- Sentry MCP
- Asana MCP

### 5. 토큰 효율 세트

- `rtk`
- `codex review`
- `codex exec`
- `resume` / `fork`

---

## 트러블슈팅

### 1. `codex`는 되는데 PATH 관련 경고가 보인다

도움말 호출 시 환경에 따라 PATH 업데이트 경고가 보일 수 있습니다.

확인:

```bash
command -v codex
codex --version
```

실제 쉘에서 정상 실행되면 문서화는 진행해도 됩니다.

### 2. `codex mcp list`가 비밀값을 그대로 보여준다

현재 환경 기준으로 stdio MCP 인자와 일부 env 값이 출력될 수 있습니다.

대응:

- 공유 전 마스킹
- 스크린샷 금지
- `config.toml` Git 추적 금지

### 3. `npx` 기반 MCP가 안 붙는다

원인 후보:

- Node.js 미설치
- `npx` 자체 문제
- 패키지 다운로드 실패

확인:

```bash
node -v
npx -v
codex mcp list
```

### 4. `uv`가 없어서 Python 계열 도구가 막힌다

설치:

```bash
brew install uv
uv --version
```

### 5. `playwright-cli`는 있는데 브라우저 테스트가 어색하다

먼저 도움말과 세션 흐름부터 확인합니다.

```bash
playwright-cli --help | sed -n '1,80p'
playwright-cli open https://example.com
playwright-cli snapshot
playwright-cli close
```

### 6. `RTK`를 Claude처럼 자동 훅으로 기대하면 안 된다

현재 문서 기준 원칙:

- Codex에서 RTK는 **직접 실행형 도구**로 본다.
- 자동 재작성은 기본 세팅으로 가정하지 않는다.

### 7. `frontend-design`이 없는데 프론트 작업 품질을 높이고 싶다

대응 순서:

1. `AGENTS.md`에 시각 규칙을 적는다.
2. 필요하면 커스텀 스킬로 이식한다.
3. Figma/Playwright 검증 루프를 붙인다.

### 8. `serena`가 없어서 아쉽다

대응:

1. `codebase-memory-mcp` 우선
2. 프로젝트 `AGENTS.md`에 탐색 규칙 고정
3. 필요 시 별도 이식 또는 대체 도구 검토

### 9. 스킬을 설치했는데 세션에서 안 보인다

일반적으로 스킬/설정 변경 후에는 Codex를 다시 시작하는 편이 안전합니다.

확인:

```bash
find ~/.codex/skills -maxdepth 3 -name SKILL.md | sort
```

### 10. 설치는 끝났는데 실제 동작이 기대와 다르다

버전 확인보다 행동 검증을 다시 돌리세요.

- `AGENTS.md`가 적용되는가
- MCP가 실제로 호출되는가
- 병렬 에이전트가 동작하는가
- 브라우저/앱 테스트 규칙이 지켜지는가

---

## 공식/로컬 참고 링크

### OpenAI 공식

- OpenAI Developers 메인: <https://developers.openai.com/>
  - `Using Codex > CLI`
  - `Configuration > Config File / Rules / AGENTS.md / MCP / Skills / Subagents`

### 로컬 확인용 명령

```bash
codex --help
codex exec --help
codex review --help
codex mcp --help
codex mcp add --help
codex features list
playwright-cli --help
rtk --version
```

### 이 저장소의 관련 문서

- `claude-code-master-setup.md`
- `ANDROID_QA_AGENT_SETUP.md`
- `docs/plans/2026-03-31-codex-master-setup-design.md`
- `docs/plans/2026-03-31-codex-master-setup-plan.md`

---

## 한 줄 요약

개인용 Codex 셋업은 `CLI + config.toml + AGENTS.md + MCP + skills`가 본체입니다. Claude 문서에서 익숙한 개념은 비교용으로만 가져오고, 설치와 운영은 Codex의 실제 제어 지점에 맞춰 다시 설계하는 편이 안전합니다.
