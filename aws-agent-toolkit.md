# AWS Agent Toolkit (AWS 공식 스킬 24개 + AWS MCP)

> AWS CLI 가 Claude Code 에 AWS 공식 스킬과 AWS MCP 서버를 설치해 주는 기능. 2026-10-17 맥미니에서 처음 설치.

## 무엇이 설치되나

- **스킬 24개** → `~/.claude/skills/` (심링크 아님, 폴더 복사)
  - amazon-bedrock, aws-ai-ml, aws-auth, aws-billing-and-cost-management, aws-blocks, aws-cdk, aws-cloudformation, aws-compute, aws-containers, aws-database, aws-deployment, aws-iam, aws-messaging-and-streaming, aws-networking, aws-observability, aws-sdk-js-v3-usage, aws-sdk-python-usage, aws-sdk-swift-usage, aws-security, aws-serverless, aws-storage, aws-well-architected-review, launch-with-aws, signing-in-to-aws
- **MCP `aws-mcp`** → `~/.claude.json` 의 user `mcpServers`
  - `uvx mcp-proxy-for-aws@latest https://aws-mcp.us-east-1.api.aws/mcp --metadata INSTALL_SOURCE=aws-cli`
  - AWS 자격증명은 기기의 AWS CLI 프로필을 쓴다

## 설치 (새 기기·회사 맥북)

사전 조건: AWS CLI v2 (`brew install awscli`, 맥미니는 2.38.1), `uvx` (`brew install uv`).

1. `aws configure` 실행 (자격증명 입력)
2. 마지막에 나오는 질문에 답한다
   - `Configure AWS skills and the AWS MCP server for your AI coding agent(s)? [y/n/never]` → `y`
   - `Install 24 default AWS skills? [Y/n]` → 엔터
   - `Configure AWS MCP server connection? [Y/n]` → 엔터
3. Claude Code 재시작

- 회사 맥북은 default 프로필이 회사 neo 계정이다. 장수 계정을 덮어쓰지 않게 주의.

### `aws configure` 를 이미 마친 기기 (별도 명령 설치)

2026-10-19 개인 맥북(AWS CLI 2.36.17)에서 확인. 질문을 다시 띄우지 않고 스킬과 MCP 를 따로 설치한다.

```bash
# 스킬 24개: 위 목록을 하나씩 추가
for s in amazon-bedrock aws-ai-ml aws-auth aws-billing-and-cost-management aws-blocks aws-cdk aws-cloudformation aws-compute aws-containers aws-database aws-deployment aws-iam aws-messaging-and-streaming aws-networking aws-observability aws-sdk-js-v3-usage aws-sdk-python-usage aws-sdk-swift-usage aws-security aws-serverless aws-storage aws-well-architected-review launch-with-aws signing-in-to-aws; do
  aws agent-toolkit add-skill --region us-east-1 --skill-name $s --agent claude-code
done

# MCP
claude mcp add --scope user aws-mcp -- uvx mcp-proxy-for-aws@latest https://aws-mcp.us-east-1.api.aws/mcp --metadata INSTALL_SOURCE=aws-cli
```

- `--region us-east-1` 필수: Agent Toolkit 은 us-east-1 에서만 동작한다. 기본 리전이 다르면(예: `ap-northeast-2`) `AgentToolkit is only available in us-east-1` 로 실패한다.
- us-east-1 은 스킬 배포·MCP 접속 엔드포인트일 뿐이다. 리소스를 만들지 않고, 프로필 기본 리전도 바꾸지 않는다(`--region` 은 그 명령에만 적용).
- `--agent claude-code` 를 빼면 감지된 모든 에이전트 도구에 설치된다.

## 확인

```bash
ls ~/.claude/skills | grep -cE '^(aws-|amazon-bedrock|launch-with-aws|signing-in-to-aws)'   # 24
claude mcp list | grep aws-mcp
```

## 추가 스킬 찾기

```bash
aws agent-toolkit search-skills --search-query <검색어>
```
