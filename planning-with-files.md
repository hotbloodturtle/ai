# planning-with-files

> Manus 스타일의 파일 기반 영속적 플래닝(Persistent Planning) 스킬

## 소개

planning-with-files는 에이전트가 계획을 파일(plan.md)로 작성하고 관리하는 스킬이다.
세션이 종료되어도 계획이 파일로 남아 컨텍스트(Context)를 유지하며, 체계적으로 작업을 진행할 수 있다.
플랫폼에 독립적인 구조로, 파일 시스템 접근이 가능한 모든 환경에서 동작한다.

## 주요 기능

- 파일 기반 계획 관리 (plan.md)
- 세션 간 계획 영속성(Persistence)
- 체크리스트(Checklist) 기반 진행 추적
- 인수인계(Handoff) 지원

## 공식 링크

- GitHub: https://github.com/OthmanAdi/planning-with-files

## 설치 (Claude Code 기준)

저장소에 6개 언어 변형(English/Spanish/Chinese/German/Traditional Chinese/Arabic)이 있으니 필요한 변형만 심링크.

### 영어판 단일 설치 (권장)
```bash
mkdir -p ~/.claude/plugins/repos ~/.claude/skills
git clone --depth 1 https://github.com/OthmanAdi/planning-with-files.git ~/.claude/plugins/repos/planning-with-files

ln -sfn ~/.claude/plugins/repos/planning-with-files/skills/planning-with-files \
  ~/.claude/skills/planning-with-files
```

### 다국어 변형 (전체)
```bash
for skill in ~/.claude/plugins/repos/planning-with-files/skills/planning-with-files*/; do
  ln -sfn "$skill" ~/.claude/skills/$(basename "$skill")
done
```

### 검증된 설치 상태 (이 기기, 2026-06-13)
- 위 권장 방식(repos 클론 + skills 하위만 flat 심링크)과 **다르게** 설치돼 있다: 레포 **전체**가 `~/.claude/skills/planning-with-files/`에 그대로 클론됨(CHANGELOG, README, commands, docs, skills 등 포함). 이 디렉토리 **최상위에 SKILL.md가 없어** Claude Code의 1단계 스캔으로는 flat 스킬로 인식되지 않는다(사실상 비활성 클론).
- 실제 활성화는 **플러그인 네임스페이스** `planning-with-files:*`(`planning-with-files:plan`, `planning-with-files:status`, `planning-with-files:planning-with-files` 등)로 되어 있다.
- 정리 옵션: ① 플러그인만 남기고 비활성 클론(`~/.claude/skills/planning-with-files/`)을 제거, 또는 ② 위 권장 방식대로 레포를 `~/.claude/plugins/repos/`로 옮기고 `skills/` 하위만 최상위로 flat 심링크.

### 업데이트
```bash
cd ~/.claude/plugins/repos/planning-with-files && git pull
```
