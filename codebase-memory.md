# Codebase Memory

> 코드베이스를 지식 그래프로 인덱싱하고 시맨틱 탐색을 지원하는 MCP 서버

## 소개

Codebase Memory는 코드베이스를 지식 그래프(Knowledge Graph)로 인덱싱하는 MCP 서버다.
함수/클래스 간 관계를 시맨틱(Semantic)하게 탐색하고, 호출 경로를 추적할 수 있다.
게이트 훅(Gate Hook)과 연동 스킬(Skill) 4개를 함께 제공하며, MCP를 지원하는 모든 클라이언트에서 사용할 수 있다.

## 주요 기능

- 코드베이스 자동 인덱싱 (index_repository)
- 시맨틱 코드 검색 (search_graph, search_code)
- 호출 경로 추적 (trace_call_path)
- 코드 스니펫 조회 (get_code_snippet)
- 아키텍처 조회 (get_architecture)
- ADR(Architecture Decision Records) 관리
- 게이트 훅: 코드 탐색 시 MCP 도구 우선 사용 유도
- 연동 스킬 4개: codebase-memory-exploring, codebase-memory-tracing, codebase-memory-reference, codebase-memory-quality

## 공식 링크

- GitHub: https://github.com/DeusData/codebase-memory-mcp

## 설치

공식 인스톨러는 macOS quarantine 속성 제거 + 코드 서명 + 모든 코딩 에이전트 자동 감지 + MCP/훅/스킬 일괄 등록까지 수행한다.

### macOS / Linux
```bash
curl -fsSL https://raw.githubusercontent.com/DeusData/codebase-memory-mcp/main/install.sh | bash
source ~/.zshrc   # ~/.local/bin이 PATH에 없었다면 자동 추가됨
```

### Windows (PowerShell)
```powershell
Invoke-WebRequest -Uri https://raw.githubusercontent.com/DeusData/codebase-memory-mcp/main/install.ps1 -OutFile install.ps1
.\install.ps1
```

### 자동 등록되는 항목 (Claude Code 기준)
- 바이너리: `~/.local/bin/codebase-memory-mcp`
- MCP 서버: `~/.claude.json`에 `codebase-memory-mcp` 등록
- 훅 2개: PreToolUse (코드 탐색 게이트), SessionStart (MCP 사용 리마인더)
- 스킬 4개: codebase-memory-exploring, tracing, reference, quality

설치 후 Claude Code 재시작 1회.

## 참고

- 제로 디펜던시(Zero Dependency) 단일 바이너리.
- 자동 분류기는 `curl ... | bash` 패턴을 차단할 수 있으므로 사용자가 직접 실행해야 함.
- PreToolUse 훅이 Read/Grep을 가로채 codebase-memory-mcp 도구로 유도하므로, 단순 텍스트 검색 시에도 게이트 메시지가 출력될 수 있음.
