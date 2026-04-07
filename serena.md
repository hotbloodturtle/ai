# Serena

> 대형 코드베이스를 위한 시맨틱(Semantic) 코드 분석 및 편집 도구 (MCP + 플러그인)

## 소개

Serena는 LSP(Language Server Protocol)와 심볼 단위 파싱을 활용하여, 에이전트가 거대한 코드베이스에서도 토큰 효율적으로 코드를 탐색하고 편집하게 해주는 도구다.
"파일을 통째로 읽지 않고 필요한 심볼만 읽는다"는 원칙으로 작동하며, 함수/클래스 단위의 검색·삽입·교체·삭제를 지원한다.
Claude Code 플러그인 마켓플레이스(`claude-plugins-official`)에서 플러그인 형태로 설치하면 MCP 서버가 자동으로 구성된다.

## 주요 기능

- **심볼 기반 탐색**: `find_symbol`, `get_symbols_overview`, `find_referencing_symbols`
- **심볼 단위 편집**: `replace_symbol_body`, `insert_after_symbol`, `insert_before_symbol`
- **패턴 검색**: `search_for_pattern` — 이름이 불확실할 때 정규식 기반 탐색
- **파일 탐색**: `find_file`, `list_dir`
- **프로젝트 온보딩**: `onboarding`, `activate_project`, `check_onboarding_performed`
- **세션 메모리**: `write_memory`, `read_memory`, `list_memories` — 프로젝트별 지식 축적
- **모드 전환**: `switch_modes` — 편집/탐색 모드 변경
- **쉘 명령**: `execute_shell_command` — 에이전트가 직접 CLI 실행

## 공식 링크

- GitHub: https://github.com/oraios/serena
- MCP 실행: `uvx --from git+https://github.com/oraios/serena serena start-mcp-server`

## 설치

Claude Code 플러그인 마켓플레이스를 사용하는 경우:

```bash
# claude-plugins-official 마켓플레이스에서 설치
/plugin install serena
```

직접 MCP로 등록하는 경우 (`~/.claude/.mcp.json` 또는 프로젝트별 설정):

```json
{
  "mcpServers": {
    "serena": {
      "command": "uvx",
      "args": ["--from", "git+https://github.com/oraios/serena", "serena", "start-mcp-server"]
    }
  }
}
```

## 참고 사항

- `uv` (Python 패키지 매니저) 필요
- 프로젝트 최초 사용 시 `onboarding` 단계를 거쳐야 심볼 인덱스가 생성됨
- Codebase Memory MCP와 역할이 유사하지만, Serena는 LSP 기반 실시간 분석에, Codebase Memory는 지식 그래프 저장에 강점이 있음
