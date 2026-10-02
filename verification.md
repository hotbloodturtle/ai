# 설치 절차 검증 기록

공용 설치 절차의 근거를 기록한다. 개인 기기의 설치 목록·경로·인증 상태는 Git 제외 `.local/`에 보관한다.

## 2026-09-08 — macOS Apple Silicon / Codex CLI 0.153.4

| 대상 | 검증 결과 | 검증 범위의 한계 |
|---|---|---|
| Superpowers 6.3.0 / Ponytail 4.9.0 | Codex 플러그인 설치·활성 목록 확인 | 모든 워크플로 실행 및 사용자 훅 신뢰는 별도 |
| BMAD 6.11.0 | 임시 프로젝트에 Codex 스킬 49개와 `_bmad/` 생성 | 전체 SDLC 작업 미실행. 기본은 전역 래퍼 |
| BMAD 플러그인 6.13.0-next | 설치·파일 검사 후 제거 | prerelease 선택지로만 문서화 |
| Spec Kit 0.16.4 | 임시 프로젝트에 Codex 스킬 10개와 `.specify/` 생성 | 실제 사용자 프로젝트는 초기화하지 않음 |
| 공통 복원 스킬 7개 | skill-creator의 quick_validate 통과 | 작업별 행동 검증을 대신하지 않음 |
| 독립 스킬 및 설치한 개발 플러그인 | 최상위 YAML 파싱·description 검사 통과, 실제 `skills/list` 활성 이름 중복·로딩 오류 0개 | 실제 로딩에서 발견한 SEO 중첩 복사본 3개 비활성화 후 재검증. 파일 수와 활성 로딩 수는 다름 |
| Codex doctor | 19 ok / 1 idle / 0 warn / 0 fail | 로컬 설치·설정·인증 구성·연결 진단이며 개별 도구 작업 검증은 별도 |
| gstack | `./setup --host codex` 성공, setup의 Chromium 실행 점검 통과 | 외부 계정·Claude 호출 등이 필요한 워크플로는 별도 |
| Codex SEO v1.9.6-codex.5 | 설치 완료, verifier `full_ready=true` | Google 등 API 인증/실제 요청 완료를 의미하지 않음 |
| Document Skills 런타임 | 기본 PDF/DOCX/PPTX/XLSX 생성·읽기 통과 | 복잡한 레이아웃/폰트/매크로는 산출물별 확인 |
| LibreOffice 26.8.0 | DOCX/PPTX PDF 변환, XLSX `SUM` 재계산 값 확인 | UI 조작 대신 headless 실행으로 확인 |
| Serena | MCP initialize + tools/list 24개 | 실제 언어 서버 프로젝트 분석은 별도 |
| Codebase Memory | MCP initialize + tools/list 14개 | 실제 코드 저장소 인덱싱은 별도 |
| Task Master 0.43.1 | MCP initialize + core tools/list 7개 | 내부 모델 provider·PRD 분해는 별도 |
| Playwright CLI 0.1.13 | 독립 테스트 세션의 about:blank 열기/닫기 | 실제 웹앱 흐름은 별도 |
| agent-device 0.20.3 | doctor의 장치 목록·iOS 러너 캐시 확인, hard blocker 없음 | Vega CLI 경고. 실제 기기 조작은 이번 검증에서 제외 |
| RTK 0.40.0 | Codex용 전역 지침 생성 | Claude 자동 재작성 훅 방식과 다름 |
| planning-with-files | 스킬·훅 파일 설치 및 no-plan 셸 entry 스모크 | fail-open 종료코드 0은 계획 주입 성공을 증명하지 않음. `/hooks` 후 실제 프로젝트에서 확인 |
| claude-squad 1.0.17 | 실행 파일 및 `-p codex` 옵션 확인 | 실제 TUI 에이전트 세션은 미생성 |

## 2026-10-02 — macOS / Claude Code

| 대상 | 검증 결과 | 검증 범위의 한계 |
|---|---|---|
| 전체 업데이트 (Claude) | document-skills 8a1541c, bmad-method 4f61d4e, planning-with-files v3.22.0, cmux 864d41d, marketing-skills c0e35b7(신규 10개 심링크), claude-seo v2.4.1(인스톨러 재실행, `seo` 심링크→실제 폴더), gstack 1.91.12(`--no-prefix`, 훅 비활성, settings.json 무변경 확인), awesome-design-md f696123(74개) | 각 워크플로 실행 검증 아님 |
| 플러그인 | ponytail 4.7.0→4.10.0, claude-hud 0.3.0→0.10.0(statusline 래퍼가 최신 버전 자동 선택 확인), slack 1.3.0 최신 | 재시작 후 반영 |
| CLI | rtk 0.50.0, claude-squad 1.0.20, playwright-cli 0.1.22, agent-device 0.21.19(doctor: warn, hard blocker 없음), Spec Kit 1.0.13(init 스모크), codebase-memory-mcp 0.11.0(`--skip-config`, MCP Connected) | Spec Kit 1.x 실제 프로젝트 워크플로 미실행 |
| Codex | ai-tools clone 갱신, planning-with-files 스킬·훅 파일 동기화(hooks.json 항목 변화 없음, session-start 스모크 exit 0), gstack `--host codex` 재실행(gstack-* 56개 유지), superpowers 6.4.2·ponytail 4.10.0 플러그인 확인, codex-seo는 최신 태그(v1.9.6-codex.5) 유지 | Codex 세션에서 `/hooks` 신뢰 재확인 필요할 수 있음 |
| Superpowers 6.4.2 | Claude: clone `git pull`(f2cbfbe→8ca22db), 심링크 14개 확인, `diagnosing-superpowers` 제외. Codex 플러그인 6.4.2 확인 | 워크플로 실행 검증 아님 |
| Matt Pocock Skills (grilling, grill-me, writing-for-agents) | skills CLI 전역 설치, 스킬 목록 로딩 확인(`grill-me`는 사용자 호출 전용이라 목록 미노출이 정상) | 실제 grilling 세션 미실행 |
| Archify 3.0.1 | skills CLI 전역 설치, `doctor` 전 항목 ok, `demo` HTML 생성, 동반 설치된 `archify-review` 제거 | 실제 레포 기반 다이어그램 생성·Codex 설치는 미실행 |

## 재현 과정에서 수정한 문제

- Codex SEO: macOS 시스템 Python 3.9 대신 Homebrew Python 3.11 사용.
- Codex SEO: Pango 누락으로 WeasyPrint 경고가 JSON 출력을 깨뜨림. Pango 설치 후 installer 재실행 성공.
- Codebase Memory: 기존 Claude 스킬의 인용되지 않은 `description` 콜론으로 YAML 파싱 실패. 저장소의 독립 복원 스킬로 교체.
- RTK: `@파일` 한 줄을 Codex에서 읽을 파일을 명시하는 문장으로 보완.
- 문서 스킬: upstream의 preinstalled 가정과 실제 기기의 차이를 독립 문서 런타임으로 해소.
- 실제 로딩 검사: 최상위 파일 검사에서 놓친 Codex SEO 확장 스킬 3개의 중복 노출 발견. 원본을 보존하고 `[[skills.config]]`에서 중첩 복사본만 비활성화한 뒤 app-server `skills/list`로 재검증.

설치 이후의 사용자 확인은 [활성화와 사용 확인](setup-guide.md#활성화와-사용-확인)을 따른다. Linux·Windows에서 직접 실행한 결과는 아직 없다.
