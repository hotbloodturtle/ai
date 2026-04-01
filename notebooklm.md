# NotebookLM Integration

> Google NotebookLM과 AI 코딩 에이전트를 연결하여 소스 기반 답변을 제공하는 스킬

## 소개

NotebookLM Integration은 Google NotebookLM에 업로드된 문서를 AI 코딩 에이전트가 직접 참조할 수 있게 해주는 스킬이다.
소스 그라운딩(Source-grounding)된 응답을 통해 환각(Hallucination)을 대폭 줄이며, 복사/붙여넣기 없이 문서 기반 작업이 가능하다.
플랫폼에 독립적인 스킬 구조로, 로컬 CLI 환경에서 동작한다.

## 주요 기능

- NotebookLM과 직접 통합 -- 복사/붙여넣기 불필요
- 소스 기반(Source-grounded) 응답으로 환각(Hallucination) 감소
- 스마트 라이브러리 관리 -- 태그/설명으로 노트북 저장, 자동 선택
- 1회 Google 로그인 후 세션 간 인증 유지

## 공식 링크

- GitHub: https://github.com/PleasePrompto/notebooklm-skill

## 설치

사용 중인 플랫폼의 스킬 설치 방식에 따라 공식 저장소를 참고하여 설치.

## 참고 사항

- 로컬 CLI 환경 전용 (웹 UI 불가)
- Python, Google 계정 필요
