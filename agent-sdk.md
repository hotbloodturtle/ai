# Claude Agent SDK

> Claude Code의 능력을 프로그래밍으로 제어하여 프로덕션급 자율 에이전트를 구축하는 공식 SDK

## 소개

Claude Agent SDK는 Anthropic이 공식 제공하는 TypeScript/JavaScript SDK다.
Claude Code가 가진 코드베이스 이해, 파일 편집, 명령 실행 능력을 프로그래밍 API로 노출하여, 개발자가 자율 에이전트(Autonomous Agent)를 직접 구축할 수 있게 한다.
기존 Claude Code SDK에서 리네이밍(Renaming)되었으며, 마이그레이션 가이드가 제공된다.

## 주요 기능

- 코드베이스 이해 및 분석
- 파일 자동 편집
- 시스템 명령 실행
- 복잡한 멀티스텝 워크플로(Multi-step Workflow) 오케스트레이션
- 자율 에이전트 실행 및 관리

## 공식 링크

- GitHub: https://github.com/anthropics/claude-agent-sdk
- 문서: https://docs.claude.com/en/api/agent-sdk/overview
- 마이그레이션 가이드: https://docs.claude.com/en/docs/claude-code/sdk/migration-guide

## 설치

```bash
npm install @anthropic-ai/claude-agent-sdk
```

## 참고 사항

- Node.js 18+ 필요
- TypeScript/JavaScript 전용
- 구 Claude Code SDK에서 리네이밍됨 (breaking changes 존재, 마이그레이션 가이드 참고)
- 내부 사용 및 고객향 제품 모두 Anthropic Commercial Terms 적용
