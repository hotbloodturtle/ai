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
# task-master-ai: npx -y task-master-ai - ✓ Connected
```

첫 호출 시 npx가 패키지를 다운로드하므로 잠시 시간이 걸릴 수 있음.

## 참고

- Node.js 필요 (npx로 실행).
- npm 패키지: `task-master-ai`
