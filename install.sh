#!/usr/bin/env bash
set -euo pipefail

SCRIPT_NAME="opencode-bwrap"
CONFIG_NAME="bwrap.conf.example"

PREFIX="${1:-${HOME}/.local}"
BINDIR="${PREFIX}/bin"
CONFIG_DIR="${HOME}/.config/opencode-bwrap"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "=========================================="
echo "Installing ${SCRIPT_NAME}"
echo "=========================================="
echo ""

if [[ $EUID -eq 0 ]] && [[ "${PREFIX}" == "${HOME}/.local" ]]; then
    echo -e "${YELLOW}Warning: Running as root but installing to user directory${NC}"
fi

echo "Creating directory: ${BINDIR}"
mkdir -p "${BINDIR}"

if [[ -f "${SCRIPT_NAME}" ]]; then
    echo "Installing: ${SCRIPT_NAME} -> ${BINDIR}/${SCRIPT_NAME}"
    install -m 755 "${SCRIPT_NAME}" "${BINDIR}/${SCRIPT_NAME}"
    echo -e "${GREEN}✓ Script installed successfully${NC}"
else
    echo -e "${RED}Error: ${SCRIPT_NAME} not found in current directory${NC}"
    exit 1
fi

echo ""
echo "Creating config directory: ${CONFIG_DIR}"
mkdir -p "${CONFIG_DIR}"

if [[ -f "${CONFIG_NAME}" ]]; then
    echo "Installing: ${CONFIG_NAME} -> ${CONFIG_DIR}/bwrap.conf.example"
    install -m 644 "${CONFIG_NAME}" "${CONFIG_DIR}/bwrap.conf.example"
    echo -e "${GREEN}✓ Example config installed successfully${NC}"
else
    echo -e "${YELLOW}Warning: ${CONFIG_NAME} not found (skipped)${NC}"
fi

echo ""
echo "=========================================="
echo "Installation Summary"
echo "=========================================="
echo "Script location: ${BINDIR}/${SCRIPT_NAME}"
echo "Config location: ${CONFIG_DIR}/"
echo ""

if [[ ":${PATH}:" == *":${BINDIR}:"* ]]; then
    echo -e "${GREEN}✓ ${BINDIR} is in your PATH${NC}"
else
    echo -e "${YELLOW}! ${BINDIR} is NOT in your PATH${NC}"
    echo ""
    echo "Add the following line to your shell profile (~/.bashrc, ~/.zshrc, etc.):"
    echo ""
    echo "    export PATH=\"${BINDIR}:\$PATH\""
    echo ""
    echo "Then reload your shell:"
    echo "    source ~/.bashrc  # or source ~/.zshrc"
fi

echo ""
echo -e "${GREEN}Installation complete!${NC}"
echo ""
echo "Usage:"
echo "    ${SCRIPT_NAME} [args...]"
echo ""
echo "To customize binds, edit:"
echo "    ${CONFIG_DIR}/bwrap.conf"
