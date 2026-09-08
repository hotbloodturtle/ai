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

## 재현 과정에서 수정한 문제

- Codex SEO: macOS 시스템 Python 3.9 대신 Homebrew Python 3.11 사용.
- Codex SEO: Pango 누락으로 WeasyPrint 경고가 JSON 출력을 깨뜨림. Pango 설치 후 installer 재실행 성공.
- Codebase Memory: 기존 Claude 스킬의 인용되지 않은 `description` 콜론으로 YAML 파싱 실패. 저장소의 독립 복원 스킬로 교체.
- RTK: `@파일` 한 줄을 Codex에서 읽을 파일을 명시하는 문장으로 보완.
- 문서 스킬: upstream의 preinstalled 가정과 실제 기기의 차이를 독립 문서 런타임으로 해소.
- 실제 로딩 검사: 최상위 파일 검사에서 놓친 Codex SEO 확장 스킬 3개의 중복 노출 발견. 원본을 보존하고 `[[skills.config]]`에서 중첩 복사본만 비활성화한 뒤 app-server `skills/list`로 재검증.

설치 이후의 사용자 확인은 [활성화와 사용 확인](setup-guide.md#활성화와-사용-확인)을 따른다. Linux·Windows에서 직접 실행한 결과는 아직 없다.
