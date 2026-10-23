# Superpowers

> 소프트웨어 개발 전 과정을 구조화하는 실전 워크플로 스킬 프레임워크(Skill Framework)

## 소개
14개 이상의 개발 워크플로를 체계적으로 구조화한 스킬 모음이다. TDD, 체계적 디버깅, 코드 리뷰, 병렬 에이전트 위임, 계획 수립 등 개발 사이클 전반을 커버한다. 각 스킬은 독립적으로 사용할 수 있으며, 조합하여 복잡한 개발 프로세스를 자동화할 수 있다.

## 주요 기능
- brainstorming: 코드 작성 전 소크라테스식(Socratic) 설계 검토
- test-driven-development: RED -> GREEN -> REFACTOR 사이클 강제
- systematic-debugging: 4단계 근본 원인 분석(Root Cause Analysis)
- writing-plans / executing-plans: 상세 구현 계획 작성 및 리뷰 체크포인트(Checkpoint) 실행
- subagent-driven-development: 서브에이전트(Subagent)에 작업 위임 + 2단계 리뷰
- dispatching-parallel-agents: 독립 태스크(Task) 병렬 처리
- requesting-code-review / receiving-code-review: 코드 리뷰 디스패치(Dispatch) 및 피드백 평가
- verification-before-completion: 완료 선언 전 검증 명령 필수 실행
- finishing-a-development-branch: 브랜치(Branch) 완료 후 통합 옵션 안내
- using-git-worktrees: 격리된 Git worktree에서 개발

## 공식 링크
- GitHub: https://github.com/obra/superpowers

## 설치 (Claude Code 기준)

2026-10-23 v7.0.1 기준 (7.0: brainstorming 재작성, 스킬 구성은 6.x와 같음 — 15개 중 14개 심링크). 이 환경은 **방법 A(clone + 심링크)를 쓴다.**

| | 방법 A: clone + 심링크 (채택) | 방법 B: 플러그인 |
|---|---|---|
| 세션 시작 훅 | 없음 | `using-superpowers` 전문(~3KB, ~800토큰)을 **매 세션 강제 주입** + "모든 응답 전 스킬 호출" 유도 |
| 토큰 비용 | 스킬 목록 description만 | 상시 주입 + 스킬 호출 증가 |
| 업데이트 | `git pull` (새 스킬은 수동 심링크) | 마켓플레이스 자동 |
| 이름 | `brainstorming` | `superpowers:brainstorming` |

### 방법 A: git clone + 심링크 (채택)
```bash
mkdir -p ~/.claude/plugins/repos ~/.claude/skills
git clone https://github.com/obra/superpowers.git ~/.claude/plugins/repos/superpowers

# diagnosing-superpowers 제외하고 심링크
for skill in ~/.claude/plugins/repos/superpowers/skills/*/; do
  name=$(basename "$skill")
  [ "$name" = diagnosing-superpowers ] && continue
  ln -sfn "$skill" ~/.claude/skills/"$name"
done
```

설치 결과(14개): brainstorming, dispatching-parallel-agents, executing-plans, finishing-a-development-branch, receiving-code-review, requesting-code-review, subagent-driven-development, systematic-debugging, test-driven-development, using-git-worktrees, using-superpowers, verification-before-completion, writing-plans, writing-skills.

제외: `diagnosing-superpowers`(v6.4.1+) — superpowers 메인테이너에게 버그 리포트를 만드는 스킬. description에 "why is it so expensive", "it took too long" 등 일반 표현이 있어 오발동 위험.

### 방법 B: 플러그인 마켓플레이스
```bash
/plugin marketplace add anthropics/claude-plugins-official
/plugin install superpowers@claude-plugins-official
```
설치 위치: `~/.claude/plugins/cache/claude-plugins-official/superpowers/<버전>`. 방법 A와 동시에 쓰지 않는다(스킬 중복).

### 업데이트
```bash
cd ~/.claude/plugins/repos/superpowers && git pull --ff-only
# 새 스킬이 생겼는지 확인 → 필요하면 위 루프로 심링크
ls ~/.claude/plugins/repos/superpowers/skills
```
