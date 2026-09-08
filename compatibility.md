# Claude / Codex 호환성

2026-09-08 upstream 문서·현재 macOS 설치 검증 기준. **지원 여부와 이번 기기에서의 작업 검증은 다르다.** 설치 절차는 링크된 개별 문서의 Claude/Codex 섹션을 따른다.

| 도구 | Claude Code | Codex | 차이 / 사용 범위 |
|---|---|---|---|
| [Superpowers](superpowers.md) | 플러그인 | 공식 플러그인 | 각 에이전트에 별도 설치 |
| [Document Skills](document-skills.md) | 플러그인/스킬 | 개별 스킬 | claude-api 제외 가능, 문서 런타임 별도 |
| [Marketing Skills](marketing-skills.md) | 스킬 | 스킬 | SEO suite와 seo-audit 이름 충돌 조정 |
| [Claude SEO](claude-seo.md) | claude-seo | codex-seo 별도 저장소 | Codex TOML agents·Python venv 포함 |
| [Context7](context7.md) | MCP | MCP | 등록 명령·설정 위치만 다름 |
| [Task Master](task-master.md) | MCP | MCP | 내부 모델 인증은 클라이언트 연결과 별개 |
| [Playwright CLI](playwright-cli.md) | CLI/스킬 | CLI/스킬 | 바이너리 공유 가능 |
| [Codebase Memory](codebase-memory.md) | MCP/스킬/훅 | MCP/스킬, 버전별 훅 | 현재 구성은 기존 바이너리+MCP+스킬, Codex 훅 미설치 |
| [Claude-Mem](claude-mem.md) | 기존 플러그인 | 자동 메모리 전체 경로 미확인 | MCP 검색만으로 자동 수집·주입까지 지원한다고 보지 않음 |
| [gstack](gstack.md) | 기본 setup | `--host codex` | Codex용 gstack-* 스킬 생성 |
| [cmux](cmux.md) | craigsc/cmux | 직접 호환 미확인 | Claude 실행 전제. Codex는 claude-squad/worktree 사용 |
| [claude-squad](claude-squad.md) | `-p claude` | `-p codex` | 실행 파일 이름은 배포본별 확인 |
| [RTK](rtk.md) | 자동 재작성 훅 | AGENTS.md + RTK.md | 동일 CLI, 자동화 방식 차이 |
| [planning-with-files](planning-with-files.md) | 스킬/플러그인 | 스킬 + Codex 훅 | 기존 훅 병합, 신뢰 확인 |
| [Awesome Design](awesome-design-md.md) | 문서/스킬 | 문서/스킬 | 공유 원본 + 독립 래퍼 |
| [Serena](serena.md) | MCP | `--context codex` MCP | 공식 현행 가이드는 수동 MCP 등록 권장 |
| [Agent SDK](agent-sdk.md) | Claude Agent SDK | Codex SDK 별도 | 패키지 교체만으로 API 호환되지 않음 |
| [BMAD](bmad-method.md) | 프로젝트 설치/플러그인 | 안정 버전 프로젝트 래퍼 | 6.11.0 검증. 선택적 플러그인 6.13.0-next는 prerelease |
| [Best Practices](best-practices.md) | CLAUDE.md/훅 | AGENTS.md/대응 기능 | Claude 명령·권한 설정은 직접 복사 불가 |
| [Ponytail](ponytail.md) | 플러그인 | 네이티브 플러그인 | node PATH 및 훅 신뢰 확인 |
| [Claude HUD](claude-hud.md) | statusline 플러그인 | 직접 설치 대상 아님 | Codex 자체 상태 표시 활용, HUD와 동등하다는 의미 아님 |
| [explain-diff](explain-diff.md) | 커맨드 또는 스킬 | 스킬 | 저장소에 공통 래퍼 보관 |
| [agent-device](agent-device.md) | CLI/스킬 | CLI/스킬 | SDK/기기 연결은 OS별 준비 |
| [Hallmark](hallmark.md) | 스킬 | 스킬 | 현재 Codex에서 기존 설치 재사용 |
| [Spec Kit](spec-kit.md) | `--integration claude` | `--integration codex --integration-options="--skills"` | 실제 작업 프로젝트에 생성 |
| [Android QA 구 가이드](android-qa-agent-setup.md) | deprecated | 새 설치 제외 | agent-device 사용 |

## 설치 완료로 보지 않는 항목

- 훅 파일은 설치됐어도 `/hooks` 신뢰 확인 전에는 활성 상태로 단정하지 않는다.
- Task Master의 모델 provider, SEO의 Google/DataForSEO/Firecrawl 등은 필요한 계정을 연결한 후 실제 요청을 검증한다.
- 스킬 파일 인식만으로 DOCX/PPTX 생성, 실제 앱 QA, 모든 gstack 워크플로가 검증됐다고 표시하지 않는다.
- SDK는 개발 중인 앱의 의존성이다. 사용 프로젝트 없이 전역 npm 패키지로 설치해도 에이전트 기능이 확장되지 않는다.
- macOS에서 성공한 결과를 Linux·Windows에서도 검증한 것으로 기록하지 않는다.

새 기기 구성은 [설치 가이드](setup-guide.md)부터 시작한다.
