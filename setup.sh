#!/usr/bin/env bash
# =============================================================================
# setup.sh
# 용도: 새 Mac에서 Claude Code 개발 환경을 한 번에 구축하는 스크립트
#
# 옵션:
#   --dry-run       실행 계획만 출력 (실제 설치 안 함)
#   --minimal       필수 항목만 설치
#   --skip-plugins  플러그인 설치 건너뛰기
#   --skip-mcp      MCP 서버 설치 건너뛰기
#   --skip-skills   스킬 저장소 클론 건너뛰기
#
# 단계:
#   1. 사전 요구사항 확인 (macOS, Xcode CLI, Node.js, Homebrew)
#   2. CLI 도구 설치 (Homebrew)
#   3. RTK 설치
#   4. Claude Code 설치
#   5. 설정 파일 복원
#   6. 플러그인 설치
#   7. MCP 서버 설정
#   8. 스킬 저장소 클론
#   9. 환경 검증
# =============================================================================

set -euo pipefail

# --- 색상 정의 ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

# --- 옵션 파싱 ---
DRY_RUN=false
MINIMAL=false
SKIP_PLUGINS=false
SKIP_MCP=false
SKIP_SKILLS=false

for arg in "$@"; do
    case "$arg" in
        --dry-run)    DRY_RUN=true ;;
        --minimal)    MINIMAL=true ;;
        --skip-plugins) SKIP_PLUGINS=true ;;
        --skip-mcp)   SKIP_MCP=true ;;
        --skip-skills) SKIP_SKILLS=true ;;
        --help|-h)
            echo "사용법: $0 [옵션]"
            echo ""
            echo "옵션:"
            echo "  --dry-run       실행 계획만 출력 (실제 설치 안 함)"
            echo "  --minimal       필수 항목만 설치"
            echo "  --skip-plugins  플러그인 설치 건너뛰기"
            echo "  --skip-mcp      MCP 서버 설치 건너뛰기"
            echo "  --skip-skills   스킬 저장소 클론 건너뛰기"
            echo "  --help, -h      도움말 출력"
            exit 0
            ;;
        *)
            echo -e "${RED}알 수 없는 옵션: ${arg}${NC}"
            echo "도움말: $0 --help"
            exit 1
            ;;
    esac
done

# --- 스크립트 경로 ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="${HOME}/.claude"

# --- 카운터 ---
SUCCESS_COUNT=0
SKIP_COUNT=0
FAIL_COUNT=0

# --- 유틸 함수 ---
log_phase() {
    echo ""
    echo -e "${BOLD}${MAGENTA}========================================${NC}"
    echo -e "${BOLD}${MAGENTA}  Phase $1: $2${NC}"
    echo -e "${BOLD}${MAGENTA}========================================${NC}"
}

log_info() {
    echo -e "  ${BLUE}[정보]${NC} $1"
}

log_success() {
    echo -e "  ${GREEN}[성공]${NC} $1"
    ((SUCCESS_COUNT++))
}

log_skip() {
    echo -e "  ${YELLOW}[건너뜀]${NC} $1"
    ((SKIP_COUNT++))
}

log_fail() {
    echo -e "  ${RED}[실패]${NC} $1"
    ((FAIL_COUNT++))
}

log_dry() {
    echo -e "  ${DIM}[DRY-RUN]${NC} $1"
}

# 명령 실행 또는 dry-run 모드 출력
run_cmd() {
    local description="$1"
    shift
    if $DRY_RUN; then
        log_dry "${description}: $*"
        ((SUCCESS_COUNT++))
    else
        log_info "${description}..."
        if eval "$@"; then
            log_success "$description"
        else
            log_fail "$description"
            return 1
        fi
    fi
}

# 명령 존재 확인
cmd_exists() {
    command -v "$1" &>/dev/null
}

# =============================================================================
# Phase 1: 사전 요구사항 확인
# =============================================================================
phase_prerequisites() {
    log_phase "1" "사전 요구사항 확인"

    # --- macOS 확인 ---
    if [[ "$(uname)" != "Darwin" ]]; then
        log_fail "이 스크립트는 macOS 전용입니다. 현재 OS: $(uname)"
        exit 1
    fi
    log_success "macOS 확인 ($(sw_vers -productVersion))"

    # --- Xcode Command Line Tools ---
    if xcode-select -p &>/dev/null; then
        log_success "Xcode Command Line Tools 설치됨"
    else
        if $DRY_RUN; then
            log_dry "Xcode Command Line Tools 설치: xcode-select --install"
            ((SUCCESS_COUNT++))
        else
            log_info "Xcode Command Line Tools 설치 중..."
            xcode-select --install 2>/dev/null || true
            echo -e "  ${YELLOW}설치 팝업이 표시되면 '설치'를 클릭하세요.${NC}"
            echo -e "  ${YELLOW}설치 완료 후 이 스크립트를 다시 실행하세요.${NC}"
            exit 0
        fi
    fi

    # --- Node.js 버전 확인 (>= 22) ---
    if cmd_exists node; then
        local node_version
        node_version=$(node --version | sed 's/v//')
        local node_major
        node_major=$(echo "$node_version" | cut -d. -f1)

        if [[ "$node_major" -ge 22 ]]; then
            log_success "Node.js ${node_version} (>= 22 충족)"
        else
            log_fail "Node.js ${node_version} (22 이상 필요)"
            echo -e "  ${YELLOW}권장: nvm install 22 또는 brew install node${NC}"
            if ! $DRY_RUN; then
                echo -e "  ${YELLOW}Node.js를 업그레이드한 후 다시 실행하세요.${NC}"
                exit 1
            fi
        fi
    else
        log_fail "Node.js 미설치"
        echo -e "  ${YELLOW}권장: nvm install 22 또는 brew install node${NC}"
        if ! $DRY_RUN; then
            echo -e "  ${YELLOW}Node.js를 설치한 후 다시 실행하세요.${NC}"
            exit 1
        fi
    fi

    # --- Homebrew ---
    if cmd_exists brew; then
        log_success "Homebrew 설치됨 ($(brew --version | head -1))"
    else
        if $DRY_RUN; then
            log_dry "Homebrew 설치: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
            ((SUCCESS_COUNT++))
        else
            log_info "Homebrew 설치 중..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            # Apple Silicon Mac 경로 설정
            if [[ -f /opt/homebrew/bin/brew ]]; then
                eval "$(/opt/homebrew/bin/brew shellenv)"
            fi
            if cmd_exists brew; then
                log_success "Homebrew 설치 완료"
            else
                log_fail "Homebrew 설치 실패"
                exit 1
            fi
        fi
    fi
}

# =============================================================================
# Phase 2: CLI 도구 설치 (Homebrew)
# =============================================================================
phase_cli_tools() {
    log_phase "2" "CLI 도구 설치 (Homebrew)"

    # 필수 도구
    local essential_tools=("jq" "uv")
    # 선택 도구 (--minimal이 아닐 때만)
    local optional_tools=("bun" "gh" "tmux")

    for tool in "${essential_tools[@]}"; do
        if cmd_exists "$tool"; then
            log_skip "${tool} 이미 설치됨"
        else
            run_cmd "${tool} 설치" "brew install ${tool}" || true
        fi
    done

    if ! $MINIMAL; then
        for tool in "${optional_tools[@]}"; do
            if cmd_exists "$tool"; then
                log_skip "${tool} 이미 설치됨"
            else
                run_cmd "${tool} 설치 (선택)" "brew install ${tool}" || true
            fi
        done
    else
        log_skip "선택 도구 건너뜀 (--minimal 모드): ${optional_tools[*]}"
    fi
}

# =============================================================================
# Phase 3: RTK 설치
# =============================================================================
phase_rtk() {
    log_phase "3" "RTK 설치"

    if cmd_exists rtk; then
        # 올바른 RTK인지 확인 (rtk-ai/tap 버전)
        local rtk_ver
        rtk_ver=$(rtk --version 2>&1 || true)
        if echo "$rtk_ver" | grep -qi "rtk"; then
            log_skip "RTK 이미 설치됨 (${rtk_ver})"
        else
            log_info "다른 rtk 패키지가 감지됨. 올바른 버전을 설치합니다."
            run_cmd "RTK 설치 (rtk-ai/tap)" "brew install rtk-ai/tap/rtk" || true
        fi
    else
        run_cmd "RTK 설치 (rtk-ai/tap)" "brew install rtk-ai/tap/rtk" || true
    fi

    # RTK_TELEMETRY_DISABLED 환경 변수 설정
    local zshrc="${HOME}/.zshrc"
    if grep -q "RTK_TELEMETRY_DISABLED=1" "$zshrc" 2>/dev/null; then
        log_skip "RTK_TELEMETRY_DISABLED=1 이미 .zshrc에 설정됨"
    else
        if $DRY_RUN; then
            log_dry ".zshrc에 RTK_TELEMETRY_DISABLED=1 추가"
            ((SUCCESS_COUNT++))
        else
            echo '' >> "$zshrc"
            echo '# RTK 텔레메트리 비활성화' >> "$zshrc"
            echo 'export RTK_TELEMETRY_DISABLED=1' >> "$zshrc"
            log_success ".zshrc에 RTK_TELEMETRY_DISABLED=1 추가됨"
        fi
    fi
}

# =============================================================================
# Phase 4: Claude Code 설치
# =============================================================================
phase_claude_code() {
    log_phase "4" "Claude Code 설치"

    if cmd_exists claude; then
        local claude_ver
        claude_ver=$(claude --version 2>&1 | head -1 || true)
        log_skip "Claude Code 이미 설치됨 (${claude_ver})"
    else
        # npm을 통한 설치 시도
        if cmd_exists npm; then
            run_cmd "Claude Code 설치 (npm)" "npm install -g @anthropic-ai/claude-code" || {
                # npm 실패 시 brew 시도
                log_info "npm 설치 실패, brew로 재시도..."
                run_cmd "Claude Code 설치 (brew)" "brew install claude-code" || true
            }
        else
            run_cmd "Claude Code 설치 (brew)" "brew install claude-code" || true
        fi
    fi
}

# =============================================================================
# Phase 5: 설정 파일 복원
# =============================================================================
phase_restore_configs() {
    log_phase "5" "설정 파일 복원"

    local restore_script="${SCRIPT_DIR}/restore-configs.sh"

    if [[ ! -f "$restore_script" ]]; then
        log_fail "restore-configs.sh를 찾을 수 없습니다: ${restore_script}"
        return 1
    fi

    # 실행 권한 부여
    chmod +x "$restore_script"

    if $DRY_RUN; then
        log_dry "설정 파일 복원: ${restore_script}"
        ((SUCCESS_COUNT++))
    else
        if bash "$restore_script"; then
            log_success "설정 파일 복원 완료"
        else
            log_fail "설정 파일 복원 실패 (일부 파일 누락 가능)"
        fi
    fi
}

# =============================================================================
# Phase 6: 플러그인 설치
# =============================================================================
phase_plugins() {
    log_phase "6" "플러그인 설치"

    if $SKIP_PLUGINS; then
        log_skip "플러그인 설치 건너뜀 (--skip-plugins)"
        return 0
    fi

    if ! cmd_exists claude && ! $DRY_RUN; then
        log_fail "claude CLI를 찾을 수 없어 플러그인 설치를 건너뜁니다."
        return 1
    fi

    # 마켓플레이스 등록
    run_cmd "마켓플레이스 등록 (anthropics/skills)" \
        "claude plugin marketplace add anthropics/skills 2>/dev/null" || true

    # 플러그인 목록
    local plugins=(
        "superpowers@claude-plugins-official"
        "serena@claude-plugins-official"
        "document-skills@anthropic-agent-skills"
        "example-skills@anthropic-agent-skills"
        "frontend-design@claude-code-plugins"
    )

    for plugin in "${plugins[@]}"; do
        local plugin_name="${plugin%%@*}"
        run_cmd "플러그인 설치: ${plugin_name}" \
            "claude plugin install '${plugin}' 2>/dev/null" || true
    done
}

# =============================================================================
# Phase 7: MCP 서버 설정
# =============================================================================
phase_mcp_servers() {
    log_phase "7" "MCP 서버 설정"

    if $SKIP_MCP; then
        log_skip "MCP 서버 설정 건너뜀 (--skip-mcp)"
        return 0
    fi

    if ! cmd_exists claude && ! $DRY_RUN; then
        log_fail "claude CLI를 찾을 수 없어 MCP 서버 설정을 건너뜁니다."
        return 1
    fi

    # Context7
    run_cmd "MCP 서버: context7" \
        "claude mcp add --scope user context7 -- npx -y @upstash/context7-mcp@latest 2>/dev/null" || true

    # Taskmaster AI
    run_cmd "MCP 서버: taskmaster-ai" \
        "claude mcp add --scope user taskmaster-ai -- npx -y task-master-ai 2>/dev/null" || true

    # Codebase Memory
    if [[ -d "${HOME}/.claude/skills/codebase-memory-exploring" ]] || $DRY_RUN; then
        run_cmd "MCP 서버: codebase-memory" \
            "curl -fsSL https://raw.githubusercontent.com/nicobailon/codebase-memory-mcp/main/install.sh | bash 2>/dev/null" || true
    else
        log_info "codebase-memory-mcp: 스킬 디렉토리가 없어 건너뜁니다."
        log_skip "codebase-memory-mcp"
    fi
}

# =============================================================================
# Phase 8: 스킬 저장소 클론
# =============================================================================
phase_skill_repos() {
    log_phase "8" "스킬 저장소 클론"

    if $SKIP_SKILLS; then
        log_skip "스킬 저장소 클론 건너뜀 (--skip-skills)"
        return 0
    fi

    if $MINIMAL; then
        log_skip "스킬 저장소 클론 건너뜀 (--minimal 모드)"
        return 0
    fi

    local skills_dir="${CLAUDE_DIR}/skills"
    mkdir -p "$skills_dir"

    # --- gstack ---
    local gstack_dir="${skills_dir}/gstack"
    if [[ -d "$gstack_dir" ]]; then
        log_skip "gstack 이미 존재: ${gstack_dir}"
    else
        run_cmd "gstack 클론" \
            "git clone https://github.com/anthropics/gstack.git '${gstack_dir}' 2>/dev/null" || true

        # gstack 설정 실행 (setup.sh가 있는 경우)
        if [[ -f "${gstack_dir}/setup.sh" ]] && ! $DRY_RUN; then
            run_cmd "gstack 설정" "bash '${gstack_dir}/setup.sh'" || true
        fi
    fi

    # --- 기타 스킬 저장소 ---
    # 형식: "저장소URL 디렉토리명"
    local repos=(
        "https://github.com/anthropics/claude-code-marketing.git marketing"
        "https://github.com/nicobailon/claude-seo.git claude-seo"
        "https://github.com/anthropics/obsidian-skill.git obsidian"
        "https://github.com/nicobailon/codebase-memory-mcp.git codebase-memory-reference"
    )

    for entry in "${repos[@]}"; do
        local repo_url="${entry%% *}"
        local dir_name="${entry##* }"
        local target_dir="${skills_dir}/${dir_name}"

        if [[ -d "$target_dir" ]]; then
            log_skip "${dir_name} 이미 존재"
        else
            run_cmd "스킬 클론: ${dir_name}" \
                "git clone '${repo_url}' '${target_dir}' 2>/dev/null" || true
        fi
    done
}

# =============================================================================
# Phase 9: 환경 검증
# =============================================================================
phase_verify() {
    log_phase "9" "환경 검증"

    local verify_script="${SCRIPT_DIR}/verify.sh"

    if [[ ! -f "$verify_script" ]]; then
        log_fail "verify.sh를 찾을 수 없습니다: ${verify_script}"
        return 1
    fi

    # 실행 권한 부여
    chmod +x "$verify_script"

    if $DRY_RUN; then
        log_dry "환경 검증: ${verify_script}"
        ((SUCCESS_COUNT++))
    else
        echo ""
        # verify.sh는 실패해도 계속 진행 (일부 항목 미통과 가능)
        bash "$verify_script" || true
        ((SUCCESS_COUNT++))
    fi
}

# =============================================================================
# 메인
# =============================================================================
main() {
    echo -e "${BOLD}${CYAN}============================================${NC}"
    echo -e "${BOLD}${CYAN}  Claude Code 개발 환경 설정${NC}"
    echo -e "${BOLD}${CYAN}  $(date '+%Y-%m-%d %H:%M:%S')${NC}"
    echo -e "${BOLD}${CYAN}============================================${NC}"

    if $DRY_RUN; then
        echo -e "${YELLOW}  * DRY-RUN 모드: 실제 설치 없이 계획만 출력합니다.${NC}"
    fi
    if $MINIMAL; then
        echo -e "${YELLOW}  * MINIMAL 모드: 필수 항목만 설치합니다.${NC}"
    fi

    echo -e "${DIM}  옵션: dry-run=${DRY_RUN} minimal=${MINIMAL} skip-plugins=${SKIP_PLUGINS} skip-mcp=${SKIP_MCP} skip-skills=${SKIP_SKILLS}${NC}"

    # --- 각 단계 실행 ---
    phase_prerequisites
    phase_cli_tools
    phase_rtk
    phase_claude_code
    phase_restore_configs

    if ! $SKIP_PLUGINS; then
        phase_plugins
    else
        log_phase "6" "플러그인 설치"
        log_skip "플러그인 설치 건너뜀 (--skip-plugins)"
    fi

    if ! $SKIP_MCP; then
        phase_mcp_servers
    else
        log_phase "7" "MCP 서버 설정"
        log_skip "MCP 서버 설정 건너뜀 (--skip-mcp)"
    fi

    if ! $SKIP_SKILLS && ! $MINIMAL; then
        phase_skill_repos
    else
        log_phase "8" "스킬 저장소 클론"
        if $MINIMAL; then
            log_skip "스킬 저장소 클론 건너뜀 (--minimal 모드)"
        else
            log_skip "스킬 저장소 클론 건너뜀 (--skip-skills)"
        fi
    fi

    phase_verify

    # --- 최종 요약 ---
    echo ""
    echo -e "${BOLD}${CYAN}============================================${NC}"
    echo -e "${BOLD}${CYAN}  최종 결과 요약${NC}"
    echo -e "${BOLD}${CYAN}============================================${NC}"
    echo -e "  ${GREEN}성공: ${SUCCESS_COUNT}${NC}"
    echo -e "  ${YELLOW}건너뜀: ${SKIP_COUNT}${NC}"
    echo -e "  ${RED}실패: ${FAIL_COUNT}${NC}"
    echo -e "${BOLD}${CYAN}============================================${NC}"

    if [[ $FAIL_COUNT -eq 0 ]]; then
        echo -e "  ${GREEN}${BOLD}모든 설정이 완료되었습니다!${NC}"
    else
        echo -e "  ${YELLOW}일부 항목이 실패했습니다. 위 로그를 확인하세요.${NC}"
    fi

    echo ""
    echo -e "${DIM}팁: 새 터미널을 열면 환경 변수가 적용됩니다.${NC}"
    echo -e "${DIM}팁: 문제가 있으면 ./verify.sh로 재검증하세요.${NC}"
}

main "$@"
