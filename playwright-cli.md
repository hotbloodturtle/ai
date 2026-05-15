# Playwright CLI

> AI 에이전트에 특화된 토큰 효율적 브라우저 자동화 도구 (Token-efficient Browser Automation for AI Agents)

## 소개

Microsoft가 공식 배포하는 Playwright CLI로, AI 에이전트가 직접 브라우저를 조작할 수 있도록 최적화된 도구다.
스냅샷을 컨텍스트에 주입하지 않고 디스크에 저장하여, 동일 작업 기준 Playwright MCP 대비 약 4배(~115k → ~25k 토큰) 절감된다.
스냅샷과 스크린샷을 통해 페이지 상태를 캡처하고, 클릭/입력 등 상호작용을 수행한다.
Playwright MCP와 별도로 작동하며 동시 사용이 가능하다.

## 주요 기능

- open / close: 브라우저 열기 및 닫기
- snapshot: 페이지 상태 캡처 (디스크 저장, 토큰 효율적)
- screenshot: 스크린샷 캡처
- click / fill: 요소 클릭, 폼(Form) 입력
- console / network: 콘솔(Console) 로그, 네트워크(Network) 요청 확인
- run-code: JavaScript 실행
- state-save: 브라우저 상태 저장 및 복원
- 프로젝트별 스킬(Skill) 등록 지원

## 공식 링크

- 공식 문서: https://playwright.dev/agent-cli/introduction
- npm 패키지: https://www.npmjs.com/package/@playwright/cli

## 설치

Node.js 18+ 필요. npm으로 글로벌 설치한다.

```bash
# 글로벌 설치 (Microsoft 공식 패키지)
npm install -g @playwright/cli@latest

# 워크스페이스 셋업 + 브라우저 바이너리
playwright-cli install
playwright-cli install-browser

# AI 에이전트 스킬 등록 (선택)
playwright-cli install --skills
```

## 참고

- 패키지명은 `@playwright/cli` (Microsoft 공식). 과거 `@anthropics/playwright-cli`로 알려진 이름은 npm에 존재하지 않음.
- Microsoft가 코딩 에이전트 용도로 MCP보다 CLI 사용을 권장한다.
