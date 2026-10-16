# 설치 절차 검증 기록

공용 설치 절차의 근거를 기록한다. 개인 기기의 설치 목록·경로·인증 상태는 Git 제외 `.local/`에 보관한다.

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
