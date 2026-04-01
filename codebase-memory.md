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

MCP를 지원하는 플랫폼(Claude Code, Codex, Cursor, Windsurf 등)에서 공식 저장소의 설치 가이드를 참고하여 등록.
설치 스크립트가 MCP 서버 + 훅 + 스킬을 한 번에 설치한다.

## 참고

- 제로 디펜던시(Zero Dependency) 단일 바이너리.
