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

### 업데이트
```bash
cd ~/.claude/plugins/repos/planning-with-files && git pull
```
