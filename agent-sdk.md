# Claude Agent SDK

> Claude Code의 능력을 프로그래밍으로 제어하여 프로덕션급 자율 에이전트를 구축하는 공식 SDK

## 소개

Claude Agent SDK는 Anthropic이 공식 제공하는 TypeScript/JavaScript 및 Python SDK다.
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
- TypeScript/JavaScript 및 Python 지원 (위 npm 예시는 TypeScript/JavaScript용)
- 구 Claude Code SDK에서 리네이밍됨 (breaking changes 존재, 마이그레이션 가이드 참고)
- 내부 사용 및 고객향 제품 모두 Anthropic Commercial Terms 적용

---

## Codex

Claude Agent SDK는 Claude 런타임을 제어한다. Codex 기반 앱은 별도의 [Codex SDK](https://developers.openai.com/codex/sdk)를 사용한다.

```bash
# 에이전트를 만드는 실제 TypeScript 프로젝트에서:
npm install @openai/codex-sdk
```

SDK는 전역 스킬이 아니므로 이 문서 저장소나 전역 npm에 미리 설치하지 않는다. Claude SDK 코드의 import만 바꿔서 호환되는 것도 아니다. 실행·이벤트·인증 API를 해당 SDK에 맞게 작성해야 한다. 두 SDK를 필요에 따라 같은 개발 기기에서 사용할 수 있다.

Claude Agent SDK의 Python 설치·사용 방법은 [현재 공식 문서](https://platform.claude.com/docs/en/agent-sdk/overview)를 확인한다.
