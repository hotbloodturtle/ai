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

- 이미 `aws configure` 를 마친 기기에서 이 질문이 다시 나오는지, 별도 명령으로 설치할 수 있는지는 아직 확인하지 않았다 (회사 맥북 세팅 때 확인 후 여기에 기록).
- 회사 맥북은 default 프로필이 회사 neo 계정이다. 장수 계정을 덮어쓰지 않게 주의.

## 확인

```bash
ls ~/.claude/skills | grep -cE '^(aws-|amazon-bedrock|launch-with-aws|signing-in-to-aws)'   # 24
claude mcp list | grep aws-mcp
```

## 추가 스킬 찾기

```bash
aws agent-toolkit search-skills --search-query <검색어>
```
