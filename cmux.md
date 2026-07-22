# cmux

> Git worktree 기반 병렬 실행 도구 (Parallel Agent Execution via Git Worktrees)

## 소개

여러 작업을 독립된 Git worktree에서 동시에 실행하여 에이전트(Agent) 간 충돌 없이 병렬 개발이 가능하다.
각 에이전트가 격리된 작업 공간에서 독립적으로 코드를 수정하므로 브랜치(Branch) 간 간섭이 없다.
Git과 bash/zsh 환경이 있으면 플랫폼에 관계없이 사용할 수 있다.

## 주요 기능

- Git worktree 기반 격리된 작업 공간 생성
- 여러 에이전트 세션(Session) 동시 실행
- 브랜치 간 독립적 작업 수행
- 자동 worktree 관리 (생성, 정리)

## 공식 링크

- GitHub: https://github.com/craigsc/cmux

## 설치

Git과 bash 또는 zsh가 필요하다. cmux는 순수 Bash 스크립트(`cmux.sh`)다 — 컴파일된 바이너리가 아니다.
**Homebrew 포뮬러(formula)는 존재하지 않는다.** 공식 인스톨러 또는 직접 git clone 방식 중 선택.

### 방법 A: 공식 인스톨러 (curl) — 과거 이 기기의 설치 방식 (2026-07-22 유실 확인)
```bash
curl -fsSL https://github.com/craigsc/cmux/releases/latest/download/install.sh | sh
```
> 공식 인스톨러는 `cmux`를 `~/.zshrc`에 **zsh 함수**로 등록한다(`type cmux`로 확인). 따라서 이 기기에는 `~/.claude/plugins/repos/cmux`나 `~/.local/bin/cmux` 심링크가 **없다** — 함수가 곧 진입점이다.

### 방법 B: git clone + bash 래퍼 — 이 기기의 현재 설치 방식 (2026-07-22)

zsh 함수(방법 A)가 `~/.zshrc`에서 유실되어 방법 B로 재설치. ⚠️ `cmux.sh`는 **shebang이 없어서** 직접 심링크하면 `sh`로 실행되어 process substitution(`< <(...)`)에서 깨진다 → 심링크 대신 **bash 래퍼 스크립트**를 쓴다:

```bash
git clone --depth 1 https://github.com/craigsc/cmux.git ~/.claude/plugins/repos/cmux
cat > ~/.local/bin/cmux <<'EOF'
#!/bin/bash
exec bash "$HOME/.claude/plugins/repos/cmux/cmux.sh" "$@"
EOF
chmod +x ~/.local/bin/cmux
```

> 래퍼 방식은 `cmux cd`처럼 현재 셸의 디렉토리를 바꾸는 동작이 서브셸에서 돌아 제한될 수 있다. 원래의 zsh 함수 방식이 필요하면 공식 인스톨러(방법 A)를 사용자가 직접 실행할 것.

### .gitignore 권장
```bash
# 프로젝트 루트에서
echo ".worktrees/" >> .gitignore
```
