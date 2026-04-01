# Playwright CLI

> AI 에이전트에 특화된 토큰 효율적 브라우저 자동화 도구 (Token-efficient Browser Automation for AI Agents)

## 소개

Microsoft Playwright 기반이지만 AI 에이전트가 직접 브라우저를 조작할 수 있도록 최적화된 CLI 도구다.
스냅샷(Snapshot)과 스크린샷(Screenshot)을 통해 페이지 상태를 캡처하고, 클릭/입력 등 상호작용을 수행한다.
Playwright MCP와 별도로 작동하며 동시 사용이 가능하다.

## 주요 기능

- open / close: 브라우저 열기 및 닫기
- snapshot: 페이지 상태 캡처 (토큰 효율적)
- screenshot: 스크린샷 캡처
- click / fill: 요소 클릭, 폼(Form) 입력
- console / network: 콘솔(Console) 로그, 네트워크(Network) 요청 확인
- run-code: JavaScript 실행
- state-save: 브라우저 상태 저장 및 복원
- 프로젝트별 스킬(Skill) 등록 지원

## 공식 링크

- GitHub: https://github.com/anthropics/playwright-cli

## 설치

npm 글로벌 설치 후 프로젝트마다 스킬 등록이 필요하다.
상세 설치 방법은 공식 저장소의 README를 참고한다.

```bash
# 글로벌 설치
npm install -g @anthropics/playwright-cli

# 프로젝트별 스킬 등록
playwright-cli install --skills
```
