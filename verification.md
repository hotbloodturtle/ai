# 설치 절차 검증 기록

공용 설치 절차의 근거를 기록한다. 개인 기기의 설치 목록·경로·인증 상태는 Git 제외 `.local/`에 보관한다.

## 2026-11-05 — macOS(MacBook Pro) / Claude Code (`scripts/update-tools.sh` 실행)

| 대상 | 검증 결과 | 검증 범위의 한계 |
|---|---|---|
| update-tools.sh | /app-pull 경유 실행 → Mac mini 기록과 같은 버전으로 수렴: rtk 1.1.0, agent-device 0.21.36(옛 데몬 0.21.31 자동 종료), Spec Kit 1.3.0, claude-hud 0.15.1, ponytail 5.3.3, clone 스킬 6개(bmad-method v6.12.0, document-skills, marketing-skills v2.14.0, planning-with-files v3.28.0, superpowers v7.0.2, awesome-design-md)·skills CLI 3개 갱신, `reverse-engineer-marketing` 신규 심링크, 깨진 심링크 없음 | 각 워크플로 실행 미검증, 플러그인은 재시작 후 반영 |
| cmux | `cmux.sh` 에 커밋 안 된 로컬 변경이 있어 스크립트가 건너뜀 | 미갱신 |
| gstack 1.91.182 | 이 기기도 `~/.claude/skills/gstack` 직접 클론이라 스크립트가 못 잡음. 자동 모드가 setup 실행을 막아 미갱신 → 작업자 수동 갱신 필요 | 미갱신 |

## 2026-11-04 — macOS(Mac mini) / Claude Code 2.1.318 (`scripts/update-tools.sh` 첫 실행)

| 대상 | 검증 결과 | 검증 범위의 한계 |
|---|---|---|
| update-tools.sh | /app-pull 경유 실행 → MacBook Pro 기록과 같은 버전으로 수렴: rtk 1.1.0, agent-device 0.21.36(옛 데몬 0.21.31 자동 종료), Spec Kit 1.3.0, claude-hud 0.15.1, ponytail 5.3.3, clone 스킬 5개·skills CLI 3개 갱신, `reverse-engineer-marketing` 신규 심링크, 깨진 심링크 없음 | 각 워크플로 실행 미검증 |
| gstack 1.91.182→**1.95.5** | 이 기기는 `~/.claude/skills/gstack` 에 직접 클론돼 있어 스크립트의 `plugins/repos/*` 순회에 안 잡힘(403커밋 뒤) → 작업자가 gstack.md 절차(pull + 훅 없는 setup + `codex` 삭제 + `proactive=false`)로 수동 갱신. settings.json 수정시각 10-28 그대로·gstack 훅 없음, 깨진 심링크 없음 | 스크립트가 이 경로를 아직 못 잡음 |

## 2026-11-04 — macOS(MacBook Pro) / Claude Code 2.1.318 (전체 최신화)

| 대상 | 검증 결과 | 검증 범위의 한계 |
|---|---|---|
| CLI (brew) | rtk 1.0.1→**1.1.0**, uv 0.13.7, gh 2.103.3, node 26.13.0 | |
| CLI (npm) | playwright-cli 0.1.23, agent-device 0.21.36 — 옛 데몬(0.21.31, 20시간)이 남아 `doctor` 가 busy 실패 → 연결 기기 없음 확인 후 `daemon stop` → `doctor` warn(hard blocker 없음) | 실제 기기 조작 미실행 |
| Spec Kit 1.3.0 | `uv tool install ... --force`, 빈 폴더 init 스모크 → `speckit-*` **9개**(1.2.3 은 10개) + `.specify/` | 실제 워크플로 미실행 |
| clone 스킬 | superpowers v7.0.2(14개 그대로), marketing-skills v2.14.0(신규 `reverse-engineer-marketing` 심링크 → 52개), document-skills ca45fc4(새 스킬 `academy-guide`·`discernment-nudge` 는 정책대로 제외), planning-with-files v3.28.0, bmad-method 클론 022be93(npm 6.12.4 그대로), awesome-design-md fcc7028(84개), claude-seo·cmux 변경 없음. 깨진 심링크 없음 | 각 워크플로 실행 검증 아님 |
| gstack 1.91.182→**1.95.4** | `git pull` + 훅 없는 setup, settings.json 무변경(shasum), `proactive=false` 유지, `codex` 스킬 삭제 | |
| skills CLI | `npx skills update -g`: hallmark·archify 갱신, 재실행 시 전부 최신. `archify-review` 재생성 없음 | |
| 플러그인 | ponytail 5.3.2→5.3.3, claude-hud 0.12.1→0.15.1, slack 1.4.1 최신 | 재시작 후 반영 |
| codebase-memory-mcp 0.12.1 | GitHub 최신 릴리스와 같음 → 업데이트 없음 | |

## 2026-10-23 — macOS / Claude Code (전체 최신화)

| 대상 | 검증 결과 | 검증 범위의 한계 |
|---|---|---|
| CLI (brew) | rtk 0.50.0→**1.0.1**(`rtk hook claude` 재작성 응답 확인, BSL 1.1 구성요소 포함 — [rtk.md](rtk.md)), uv 0.13.5, gh 2.103.0, tmux 3.8, node 26.12.1. claude-squad 1.0.20·playwright-cli 0.1.22는 이미 최신 | |
| agent-device 0.21.31 | npm 전역 업데이트, 예전 0.21.19 데몬 종료·남은 잠금 파일 정리 후 `doctor` warn(hard blocker 없음, [agent-device.md](agent-device.md#검증-이력)) | 실제 기기 조작 미실행 |
| Spec Kit 1.2.3 | `uv tool install ... --force`, 빈 폴더 init 스모크(`speckit-*` 10개 + `.specify/`) | 실제 프로젝트 워크플로 미실행 |
| BMAD 6.12.4 | 빈 폴더 스모크 설치 → `bmad-*` 29개 + `_bmad/` | 워크플로 미실행 |
| codebase-memory-mcp 0.12.1 | `install.sh --skip-config`(바이너리만), MCP initialize + tools/list(17개) 직접 확인, settings.json 변경 없음. 기기 스킬이 깨진 원본으로 돌아가 있어 저장소 복원본으로 교체 | 실행 중 세션의 MCP 는 재시작 후 재연결 |
| clone 스킬 | Superpowers 6.4.2→**7.0.1**(구성 동일, 14개 심링크), document-skills dbd4588(신규 2개는 기존 정책대로 제외), marketing-skills v2.13.0(신규 2개 심링크 → 51개), planning-with-files v3.25.0, bmad-method 클론 61e01f8, awesome-design-md 3b60532(84개), cmux 최신 | 각 워크플로 실행 검증 아님 |
| claude-seo v2.5.0 | 인스톨러 재실행(`seo*` 33개, 에이전트 20개), `seo-audit` 실제 폴더 유지 | 감사 실행 미검증 |
| gstack 1.91.182 | `git pull` + 훅 없는 setup, settings.json 무변경 확인, `proactive=false` 유지, 다시 생긴 `codex` 스킬 삭제 | |
| skills CLI | `npx skills update -g`: hallmark·archify(3.2)·grilling 갱신, `archify-review` 재생성 없음 | 실제 생성 미실행 |
| 플러그인 | ponytail 4.10.0→**5.3.2**(훅 3개, 상시 ~641토큰), claude-hud 0.10.0→0.12.1(래퍼가 최신 버전 자동 선택), slack 1.4.1 최신 | 재시작 후 반영 |
| Codex 정리 | 기기에서 Codex 전부 제거: `@openai/codex` CLI(`npm uninstall -g`), `~/.codex`, `~/.claude/skills/codex`(gstack 래퍼), `~/.local/share/ai-tools/codex-seo`. 문서에는 이미 없음 | |

## 2026-10-02 — macOS / Claude Code

| 대상 | 검증 결과 | 검증 범위의 한계 |
|---|---|---|
| 전체 업데이트 (Claude) | document-skills 8a1541c, bmad-method 4f61d4e, planning-with-files v3.22.0, cmux 864d41d, marketing-skills c0e35b7(신규 10개 심링크), claude-seo v2.4.1(인스톨러 재실행, `seo` 심링크→실제 폴더), gstack 1.91.12(`--no-prefix`, 훅 비활성, settings.json 무변경 확인), awesome-design-md f696123(74개) | 각 워크플로 실행 검증 아님 |
| 플러그인 | ponytail 4.7.0→4.10.0, claude-hud 0.3.0→0.10.0(statusline 래퍼가 최신 버전 자동 선택 확인), slack 1.3.0 최신 | 재시작 후 반영 |
| CLI | rtk 0.50.0, claude-squad 1.0.20, playwright-cli 0.1.22, agent-device 0.21.19(doctor: warn, hard blocker 없음), Spec Kit 1.0.13(init 스모크), codebase-memory-mcp 0.11.0(`--skip-config`, MCP Connected) | Spec Kit 1.x 실제 프로젝트 워크플로 미실행 |
| Superpowers 6.4.2 | Claude: clone `git pull`(f2cbfbe→8ca22db), 심링크 14개 확인, `diagnosing-superpowers` 제외 | 워크플로 실행 검증 아님 |
| Matt Pocock Skills (grilling, grill-me, writing-for-agents) | skills CLI 전역 설치, 스킬 목록 로딩 확인(`grill-me`는 사용자 호출 전용이라 목록 미노출이 정상) | 실제 grilling 세션 미실행 |
| Archify 3.0.1 | skills CLI 전역 설치, `doctor` 전 항목 ok, `demo` HTML 생성, 동반 설치된 `archify-review` 제거 | 실제 레포 기반 다이어그램 생성은 미실행 |

## 재현 과정에서 수정한 문제

- Codebase Memory: 기존 Claude 스킬의 인용되지 않은 `description` 콜론으로 YAML 파싱 실패. 저장소의 독립 복원 스킬로 교체.
- 문서 스킬: upstream의 preinstalled 가정과 실제 기기의 차이를 독립 문서 런타임으로 해소.

설치 이후의 사용자 확인은 [활성화와 사용 확인](setup-guide.md#활성화와-사용-확인)을 따른다. Linux·Windows에서 직접 실행한 결과는 아직 없다.
