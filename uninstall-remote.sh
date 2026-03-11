#!/usr/bin/env bash
set -euo pipefail

REPO="cyunrei/opencode-bwrap"
BINDIR="${HOME}/.local/bin"
CONFIG_DIR="${HOME}/.config/opencode-bwrap"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

error() {
    echo -e "${RED}Error: $1${NC}" >&2
    exit 1
}

success() {
    echo -e "${GREEN}$1${NC}"
}

warning() {
    echo -e "${YELLOW}$1${NC}"
}

info() {
    echo -e "${BLUE}$1${NC}"
}

main() {
    echo "=========================================="
    echo "Opencode-Bwrap Remote Uninstaller"
    echo "Repository: ${REPO}"
    echo "=========================================="
    echo ""
    
    local script_removed=false
    local config_removed=false
    
    if [[ -f "${BINDIR}/opencode-bwrap" ]]; then
        info "Removing: ${BINDIR}/opencode-bwrap"
        rm -f "${BINDIR}/opencode-bwrap"
        success "✓ Script removed"
        script_removed=true
    else
        warning "! Script not found at ${BINDIR}/opencode-bwrap"
    fi
    
    echo ""
    if [[ -d "${CONFIG_DIR}" ]]; then
        echo -e "${YELLOW}Configuration directory found: ${CONFIG_DIR}${NC}"
        read -p "Do you want to remove configuration files? (y/N): " -n 1 -r
        echo ""
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm -rf "${CONFIG_DIR}"
            success "✓ Configuration removed"
            config_removed=true
        else
            warning "! Configuration kept at: ${CONFIG_DIR}"
        fi
    else
        info "Configuration directory not found"
    fi
    
    echo ""
    echo "=========================================="
    if [[ "$script_removed" == true ]] || [[ "$config_removed" == true ]]; then
        success "Uninstallation complete!"
    else
        warning "Nothing was removed"
    fi
    echo "=========================================="
}

main "$@"
