# claude-squad

> 터미널 기반 멀티 에이전트 오케스트레이션(Orchestration) 도구

## 소개

여러 AI 에이전트를 tmux 세션(Session)에서 동시에 실행하고 관리하는 도구다.
각 에이전트에 독립된 작업을 할당하고 진행 상황을 실시간으로 모니터링할 수 있다.
작업 완료 후 결과를 통합하여 효율적인 병렬 개발 워크플로(Workflow)를 구성한다.

## 주요 기능

- tmux 기반 멀티 에이전트 관리
- 에이전트별 독립 작업 할당
- 실시간 진행 모니터링(Monitoring)
- 결과 통합 및 리뷰(Review)

## 공식 링크

- GitHub: https://github.com/smtg-ai/claude-squad

## 설치

tmux와 gh (GitHub CLI)가 사전에 설치되어 있어야 한다.
상세 설치 방법은 공식 저장소의 README를 참고한다.

```bash
brew install claude-squad
```

---

## Codex

같은 바이너리로 Codex를 실행할 수 있다. 기본 Claude 설정을 바꾸지 않고 실행 시 지정한다.

```bash
claude-squad -p "codex"
# 실행 파일이 cs인 배포본:
# cs -p "codex"
```

2026-09 검증한 Homebrew 1.0.17은 `claude-squad`라는 실행 파일이며 `-p/--program`을 지원한다. `command -v claude-squad cs`로 설치 결과를 확인한다. `tmux`, `gh`, `codex`가 PATH에 있어야 한다. TUI 세션은 실제 Git 프로젝트의 터미널에서 실행한다. 이번 설치 작업에서는 도움말과 바이너리 확인까지 했으며 작업 세션을 자동 생성하지 않았다.

[upstream 사용 안내](https://github.com/smtg-ai/claude-squad)
