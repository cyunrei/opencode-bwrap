#!/usr/bin/env bash
set -euo pipefail

REPO="cyunrei/opencode-bwrap"
BRANCH="master"
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

info() {
    echo -e "${BLUE}$1${NC}"
}

success() {
    echo -e "${GREEN}$1${NC}"
}

warning() {
    echo -e "${YELLOW}$1${NC}"
}

check_dependencies() {
    info "Checking dependencies..."
    
    if ! command -v curl >/dev/null 2>&1; then
        error "curl is required but not installed"
    fi
    
    if ! command -v bwrap >/dev/null 2>&1; then
        error "bubblewrap (bwrap) is required but not installed"
    fi
    
    if ! command -v opencode >/dev/null 2>&1; then
        error "opencode is required but not found in PATH"
    fi
    
    success "✓ All dependencies satisfied"
}

download_file() {
    local url="$1"
    local output="$2"
    
    if ! curl -fsSL "$url" -o "$output"; then
        error "Failed to download from: $url"
    fi
}

main() {
    echo "=========================================="
    echo "Opencode-Bwrap Remote Installer"
    echo "=========================================="
    echo ""
    
    check_dependencies
    
    info "Installing from: ${REPO} (${BRANCH})"
    info "Install directory: ${BINDIR}"
    echo ""
    
    mkdir -p "${BINDIR}"
    mkdir -p "${CONFIG_DIR}"
    
    info "Downloading opencode-bwrap..."
    download_file "https://raw.githubusercontent.com/${REPO}/${BRANCH}/opencode-bwrap" "${BINDIR}/opencode-bwrap"
    chmod +x "${BINDIR}/opencode-bwrap"
    success "✓ Script installed"
    
    info "Downloading example config..."
    download_file "https://raw.githubusercontent.com/${REPO}/${BRANCH}/bwrap.conf.example" "${CONFIG_DIR}/bwrap.conf.example"
    success "✓ Example config installed"
    
    echo ""
    echo "=========================================="
    echo "Installation Summary"
    echo "=========================================="
    echo "Script: ${BINDIR}/opencode-bwrap"
    echo "Config: ${CONFIG_DIR}/bwrap.conf.example"
    echo ""
    
    if [[ ":${PATH}:" == *":${BINDIR}:"* ]]; then
        success "✓ ${BINDIR} is in your PATH"
    else
        warning "! ${BINDIR} is NOT in your PATH"
        echo ""
        echo "Add this to your shell profile (~/.bashrc, ~/.zshrc, etc.):"
        echo ""
        echo "    export PATH=\"${BINDIR}:\$PATH\""
        echo ""
        echo "Then reload: source ~/.bashrc"
    fi

    echo ""
    success "Installation complete!"
    echo ""
    echo "Usage:"
    echo "    opencode-bwrap [args...]"
    echo ""
    echo "Configure binds by creating:"
    echo "    ${CONFIG_DIR}/bwrap.conf"
}

main "$@"
