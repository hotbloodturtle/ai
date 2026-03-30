#!/usr/bin/env bash
# =============================================================================
# verify.sh
# 용도: Claude Code 개발 환경 설정 상태를 검증하는 스크립트
# - CLI 도구 설치 확인
# - 설정 파일 존재 확인
# - 규칙/템플릿/훅/스킬 확인
# - 플러그인 설치 확인
# - 환경 변수 확인
# 결과를 색상 표로 출력하고 총점을 표시
# =============================================================================

set -euo pipefail

# --- 색상 정의 ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

# --- 경로 설정 ---
CLAUDE_DIR="${HOME}/.claude"

# --- 카운터 ---
PASS_COUNT=0
FAIL_COUNT=0
TOTAL_COUNT=0

# --- 함수: 검증 결과 출력 ---
# $1: 항목 이름
# $2: 통과 여부 (0=통과, 1=실패)
# $3: 부가 정보 (선택)
print_result() {
    local name="$1"
    local status="$2"
    local detail="${3:-}"

    ((TOTAL_COUNT++))

    if [[ "$status" -eq 0 ]]; then
        ((PASS_COUNT++))
        printf "  ${GREEN}[PASS]${NC} %-40s %s\n" "$name" "${DIM}${detail}${NC}"
    else
        ((FAIL_COUNT++))
        printf "  ${RED}[FAIL]${NC} %-40s %s\n" "$name" "${DIM}${detail}${NC}"
    fi
}

# --- 함수: 섹션 헤더 출력 ---
print_section() {
    echo ""
    echo -e "${BOLD}${CYAN}── $1 ──${NC}"
}

# --- 함수: CLI 도구 버전 확인 ---
check_cli_tool() {
    local tool_name="$1"
    local version_cmd="${2:---version}"

    local version_output
    if version_output=$($tool_name $version_cmd 2>&1 | head -1); then
        print_result "$tool_name" 0 "$version_output"
    else
        print_result "$tool_name" 1 "미설치"
    fi
}

# --- 함수: 파일 존재 확인 ---
check_file_exists() {
    local file_path="$1"
    local display_name="${2:-$(basename "$file_path")}"

    if [[ -f "$file_path" ]]; then
        print_result "$display_name" 0 "$file_path"
    else
        print_result "$display_name" 1 "파일 없음"
    fi
}

# --- 함수: 파일 실행 권한 확인 ---
check_file_executable() {
    local file_path="$1"
    local display_name="${2:-$(basename "$file_path")}"

    if [[ -f "$file_path" ]]; then
        if [[ -x "$file_path" ]]; then
            print_result "${display_name} (실행 권한)" 0 ""
        else
            print_result "${display_name} (실행 권한)" 1 "실행 권한 없음"
        fi
    else
        print_result "${display_name}" 1 "파일 없음"
    fi
}

# =============================================================================
# 메인
# =============================================================================
main() {
    echo -e "${BOLD}============================================${NC}"
    echo -e "${BOLD}  Claude Code 환경 검증${NC}"
    echo -e "${BOLD}  $(date '+%Y-%m-%d %H:%M:%S')${NC}"
    echo -e "${BOLD}============================================${NC}"

    # -----------------------------------------------------------------
    # 1. CLI 도구 확인
    # -----------------------------------------------------------------
    print_section "1. CLI 도구"

    check_cli_tool "claude" "--version"
    check_cli_tool "rtk" "--version"
    check_cli_tool "bun" "--version"
    check_cli_tool "jq" "--version"
    check_cli_tool "uv" "--version"
    check_cli_tool "gh" "--version"

    # -----------------------------------------------------------------
    # 2. 설정 파일 확인
    # -----------------------------------------------------------------
    print_section "2. 설정 파일 (~/.claude/)"

    check_file_exists "${CLAUDE_DIR}/CLAUDE.md" "CLAUDE.md"
    check_file_exists "${CLAUDE_DIR}/settings.json" "settings.json"
    check_file_exists "${CLAUDE_DIR}/RTK.md" "RTK.md"

    # -----------------------------------------------------------------
    # 3. 규칙 파일 확인 (4개)
    # -----------------------------------------------------------------
    print_section "3. 규칙 파일 (~/.claude/rules/)"

    local rule_files=("frontend.md" "backend.md" "data-analysis.md" "presentation.md")
    for rule in "${rule_files[@]}"; do
        check_file_exists "${CLAUDE_DIR}/rules/${rule}" "rules/${rule}"
    done

    # -----------------------------------------------------------------
    # 4. 템플릿 파일 확인 (3개)
    # -----------------------------------------------------------------
    print_section "4. 템플릿 파일 (~/.claude/templates/)"

    local template_files=("deck-template.md" "metric-glossary.md" "review-rules.md")
    for tmpl in "${template_files[@]}"; do
        check_file_exists "${CLAUDE_DIR}/templates/${tmpl}" "templates/${tmpl}"
    done

    # -----------------------------------------------------------------
    # 5. 훅 파일 확인 (2개 + 실행 권한)
    # -----------------------------------------------------------------
    print_section "5. 훅 파일 (~/.claude/hooks/)"

    local hook_files=("cbm-code-discovery-gate" "rtk-rewrite.sh")
    for hook in "${hook_files[@]}"; do
        check_file_exists "${CLAUDE_DIR}/hooks/${hook}" "hooks/${hook}"
        check_file_executable "${CLAUDE_DIR}/hooks/${hook}" "hooks/${hook}"
    done

    # -----------------------------------------------------------------
    # 6. 커스텀 스킬 확인 (SKILL.md 10개)
    # -----------------------------------------------------------------
    print_section "6. 커스텀 스킬 (~/.claude/skills/)"

    # 직접 소유 스킬 디렉토리 (gstack, claude-seo 등 외부 클론 제외)
    local skill_dirs=(
        "commit-msg" "daily-report" "explain" "fix" "my-style"
        "refactor" "review" "start-project" "test" "translate"
    )
    for skill in "${skill_dirs[@]}"; do
        local skill_md="${CLAUDE_DIR}/skills/${skill}/SKILL.md"
        if [[ -f "$skill_md" ]]; then
            print_result "skills/${skill}/SKILL.md" 0 ""
        else
            print_result "skills/${skill}/SKILL.md" 1 "파일 없음"
        fi
    done

    # -----------------------------------------------------------------
    # 7. 플러그인 확인
    # -----------------------------------------------------------------
    print_section "7. 플러그인"

    local plugins=("superpowers" "document-skills" "frontend-design" "serena")
    local plugin_list
    plugin_list=$(claude plugin list 2>/dev/null || echo "")

    if [[ -z "$plugin_list" ]]; then
        # plugin list 명령 실패 시 settings.json에서 확인
        for plugin in "${plugins[@]}"; do
            if grep -q "\"${plugin}@" "${CLAUDE_DIR}/settings.json" 2>/dev/null; then
                print_result "플러그인: ${plugin}" 0 "settings.json에서 확인"
            else
                print_result "플러그인: ${plugin}" 1 "미등록"
            fi
        done
    else
        for plugin in "${plugins[@]}"; do
            if echo "$plugin_list" | grep -qi "$plugin"; then
                print_result "플러그인: ${plugin}" 0 ""
            else
                print_result "플러그인: ${plugin}" 1 "미설치"
            fi
        done
    fi

    # -----------------------------------------------------------------
    # 8. 환경 변수 확인
    # -----------------------------------------------------------------
    print_section "8. 환경 변수"

    # RTK_TELEMETRY_DISABLED 확인 (현재 셸 또는 .zshrc에서)
    if [[ "${RTK_TELEMETRY_DISABLED:-}" == "1" ]]; then
        print_result "RTK_TELEMETRY_DISABLED=1" 0 "현재 셸에서 설정됨"
    elif grep -q "RTK_TELEMETRY_DISABLED=1" "${HOME}/.zshrc" 2>/dev/null; then
        print_result "RTK_TELEMETRY_DISABLED=1" 0 ".zshrc에 설정됨 (재시작 필요)"
    else
        print_result "RTK_TELEMETRY_DISABLED=1" 1 "미설정"
    fi

    # -----------------------------------------------------------------
    # 결과 요약
    # -----------------------------------------------------------------
    echo ""
    echo -e "${BOLD}============================================${NC}"
    echo -e "${BOLD}  검증 결과 요약${NC}"
    echo -e "${BOLD}============================================${NC}"
    echo ""

    local pass_color="${GREEN}"
    if [[ $PASS_COUNT -lt $TOTAL_COUNT ]]; then
        pass_color="${YELLOW}"
    fi
    if [[ $FAIL_COUNT -gt $((TOTAL_COUNT / 2)) ]]; then
        pass_color="${RED}"
    fi

    echo -e "  ${GREEN}통과: ${PASS_COUNT}${NC}  /  ${RED}실패: ${FAIL_COUNT}${NC}  /  전체: ${TOTAL_COUNT}"
    echo ""
    echo -e "  ${pass_color}${BOLD}검증 결과: ${PASS_COUNT}/${TOTAL_COUNT} 항목 통과${NC}"
    echo ""

    if [[ $FAIL_COUNT -eq 0 ]]; then
        echo -e "  ${GREEN}모든 항목이 정상입니다!${NC}"
    elif [[ $FAIL_COUNT -le 5 ]]; then
        echo -e "  ${YELLOW}일부 항목을 확인해 주세요.${NC}"
    else
        echo -e "  ${RED}다수의 항목이 실패했습니다. setup.sh를 실행해 주세요.${NC}"
    fi
    echo -e "${BOLD}============================================${NC}"

    # 실패 항목이 있으면 종료 코드 1
    if [[ $FAIL_COUNT -gt 0 ]]; then
        exit 1
    fi
}

main "$@"
