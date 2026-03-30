#!/usr/bin/env bash
# =============================================================================
# restore-configs.sh
# 용도: configs/ 디렉토리의 설정 파일을 ~/.claude/로 복원
# - 기존 파일은 .bak 접미사로 백업
# - 필요한 디렉토리 자동 생성
# - 훅(Hook) 파일에 실행 권한 부여
# - settings.json의 $HOME/ 경로를 실제 홈 경로로 치환
# =============================================================================

set -euo pipefail

# --- 색상 정의 ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # 색상 초기화

# --- 경로 설정 ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIGS_DIR="${SCRIPT_DIR}/configs"
CLAUDE_DIR="${HOME}/.claude"

# --- 카운터 ---
RESTORED=0
BACKED_UP=0
SKIPPED=0
FAILED=0

# --- 함수: 로그 출력 ---
log_info() {
    echo -e "${BLUE}[정보]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[완료]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[경고]${NC} $1"
}

log_error() {
    echo -e "${RED}[오류]${NC} $1"
}

# --- 함수: 단일 파일 복원 ---
# $1: 소스 파일 (configs/ 기준 상대 경로)
restore_file() {
    local rel_path="$1"
    local src="${CONFIGS_DIR}/${rel_path}"
    local dest="${CLAUDE_DIR}/${rel_path}"
    local dest_dir
    dest_dir="$(dirname "$dest")"

    # 소스 파일 존재 확인
    if [[ ! -f "$src" ]]; then
        log_error "소스 파일 없음: ${src}"
        ((FAILED++))
        return 1
    fi

    # 대상 디렉토리 생성
    if [[ ! -d "$dest_dir" ]]; then
        mkdir -p "$dest_dir"
        log_info "디렉토리 생성: ${dest_dir}"
    fi

    # 기존 파일 백업
    if [[ -f "$dest" ]]; then
        local backup="${dest}.bak"
        cp "$dest" "$backup"
        log_info "백업 생성: ${dest} -> ${backup}"
        ((BACKED_UP++))
    fi

    # 파일 복사
    cp "$src" "$dest"
    ((RESTORED++))

    # settings.json인 경우 $HOME/ 경로 치환
    if [[ "$(basename "$rel_path")" == "settings.json" ]]; then
        # $HOME/ 문자열을 실제 홈 경로로 치환
        if grep -q '\$HOME/' "$dest" 2>/dev/null; then
            sed -i '' "s|\\\$HOME/|${HOME}/|g" "$dest"
            log_info "settings.json: \$HOME/ -> ${HOME}/ 경로 치환 완료"
        fi
    fi

    # 훅(Hook) 파일인 경우 실행 권한 부여
    if [[ "$rel_path" == hooks/* ]]; then
        chmod +x "$dest"
        log_info "실행 권한 부여: ${dest}"
    fi

    log_success "복원: ${rel_path}"
}

# --- 메인 ---
main() {
    echo -e "${BOLD}============================================${NC}"
    echo -e "${BOLD}  Claude Code 설정 파일 복원${NC}"
    echo -e "${BOLD}============================================${NC}"
    echo ""

    # configs 디렉토리 확인
    if [[ ! -d "$CONFIGS_DIR" ]]; then
        log_error "configs 디렉토리를 찾을 수 없습니다: ${CONFIGS_DIR}"
        exit 1
    fi

    # configs/ 내 모든 파일 검색 및 복원
    local file_count=0
    while IFS= read -r -d '' file; do
        # configs/ 기준 상대 경로 추출
        local rel_path="${file#${CONFIGS_DIR}/}"
        file_count=$((file_count + 1))
        log_info "--- [${file_count}] ${rel_path} ---"
        restore_file "$rel_path" || true
    done < <(find "$CONFIGS_DIR" -type f -print0 | sort -z)

    # 파일이 하나도 없는 경우
    if [[ $file_count -eq 0 ]]; then
        log_warn "configs/ 디렉토리에 복원할 파일이 없습니다."
        echo ""
        echo -e "${YELLOW}팁: configs/ 디렉토리에 다음과 같은 구조로 파일을 배치하세요:${NC}"
        echo "  configs/CLAUDE.md"
        echo "  configs/RTK.md"
        echo "  configs/settings.json"
        echo "  configs/rules/*.md"
        echo "  configs/templates/*.md"
        echo "  configs/hooks/*"
        echo "  configs/skills/*/SKILL.md"
        exit 0
    fi

    # --- 요약 출력 ---
    echo ""
    echo -e "${BOLD}============================================${NC}"
    echo -e "${BOLD}  복원 결과 요약${NC}"
    echo -e "${BOLD}============================================${NC}"
    echo -e "  복원 완료:  ${GREEN}${RESTORED}${NC} 개"
    echo -e "  백업 생성:  ${BLUE}${BACKED_UP}${NC} 개"
    echo -e "  건너뜀:     ${YELLOW}${SKIPPED}${NC} 개"
    echo -e "  실패:       ${RED}${FAILED}${NC} 개"
    echo -e "${BOLD}============================================${NC}"

    if [[ $FAILED -gt 0 ]]; then
        log_warn "일부 파일 복원에 실패했습니다. 위 로그를 확인하세요."
        exit 1
    else
        log_success "모든 설정 파일이 정상적으로 복원되었습니다!"
    fi
}

main "$@"
