# Task Master

> PRD를 구조화된 태스크로 자동 분해하고 프로젝트 진행을 관리하는 MCP 서버

## 소개

Task Master는 PRD(Product Requirements Document)를 구조화된 태스크(Task)로 자동 분해하는 MCP 서버다.
태스크 간 의존성(Dependency) 관리, 우선순위 설정, 진행 추적 등 프로젝트 관리 기능을 제공한다.
MCP를 지원하는 모든 클라이언트에서 사용할 수 있다.

## 주요 기능

- PRD -> 구조화된 태스크 자동 분해
- 태스크 간 의존성(Dependency) 관리
- 우선순위 설정 및 진행 추적
- 태스크 확장/축소 (Scope 조정)

## 공식 링크

- GitHub: https://github.com/eyaltoledano/claude-task-master
- npm 패키지: task-master-ai

## 설치

### Claude Code (stdio via npx)
```bash
claude mcp add --scope user task-master-ai -- npx -y task-master-ai
```

### 검증
```bash
claude mcp list
# taskmaster-ai: npx -y task-master-ai - ✓ Connected
```

> `claude mcp add`의 첫 인자가 곧 등록명이 되어 `claude mcp list`에 그 이름으로 표시된다. 기기마다 등록명이 다를 수 있으니(예: `task-master-ai` vs `taskmaster-ai`) 검증 시 이름이 아니라 `task-master-ai` 패키지 연결 여부로 확인한다.

## Codex

```bash
codex mcp add task-master --env TASK_MASTER_TOOLS=core -- npx -y task-master-ai@0.43.1
```

2026-09-08에는 0.43.1의 MCP 초기화와 core 도구 7개 조회를 확인했다. 전체 도구를 항상 노출할 필요는 없으므로 core로 시작하고 필요한 경우 설치 버전의 도구 선택 옵션을 확인한다.

Task Master는 **Codex에 연결되는 MCP 서버**이면서 **자체 모델을 호출하는 도구**다. MCP 등록만으로 Claude 의존성이 없어지는 것은 아니다. 실제 작업 프로젝트에서 Task Master의 model setup을 실행해 OpenAI 또는 Codex CLI provider를 선택한다. [현재 upstream](https://github.com/eyaltoledano/claude-task-master)은 Codex CLI의 ChatGPT OAuth도 지원한다고 명시한다. 프로젝트 설정 형식과 지원 모델은 설치 버전에서 확인한다.

API 키 방식이면 해당 provider의 키를 현재 기기에서 별도 설정한다. Claude용 `.taskmaster/config.json`의 모델 설정을 그대로 두면 내부 호출은 계속 Claude일 수 있다. 이번 전역 설치에서는 임의 프로젝트를 만들거나 유료 PRD 분석 요청을 실행하지 않았다. 새 프로젝트에서 provider 설정 후 작은 PRD로 작업 검증한다.

첫 호출 시 npx가 패키지를 다운로드하므로 잠시 시간이 걸릴 수 있음.

## 참고

- Node.js 필요 (npx로 실행).
- npm 패키지: `task-master-ai`
