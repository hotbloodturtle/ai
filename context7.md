# Context7

> 최신 라이브러리 문서와 코드 예시를 에이전트 컨텍스트에 직접 주입하는 MCP 서버

## 소개

Context7은 최신 버전의 라이브러리 문서와 실제 동작하는 코드 예시를 에이전트의 컨텍스트(Context)에 직접 주입하는 MCP 서버다.
LLM의 학습 데이터가 오래되어 존재하지 않는 API를 호출하는 환각(Hallucination) 문제를 방지한다.
MCP를 지원하는 모든 클라이언트에서 사용할 수 있다.

## 주요 기능

- 최신 버전별 라이브러리 문서 제공
- 실제 동작하는 코드 예시 포함
- 오래된 API 호출 방지 (환각 감소)
- 별도 API 키 불필요

## 공식 링크

- GitHub: https://github.com/upstash/context7

## 설치

### Claude Code (HTTP 트랜스포트, 권장)
```bash
claude mcp add --transport http --scope user context7 https://mcp.context7.com/mcp
```

### 다른 클라이언트 (stdio via npx)
Node.js가 있다면 `npx -y @upstash/context7-mcp` 명령을 stdio MCP로 등록.

### 검증
```bash
claude mcp list
# context7: https://mcp.context7.com/mcp (HTTP) - ✓ Connected
```

## 참고

- 별도 API 키 불필요.
- HTTP 트랜스포트는 npx 다운로드가 없어 첫 호출이 빠름.
