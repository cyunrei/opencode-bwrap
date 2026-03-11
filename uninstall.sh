#!/usr/bin/env bash
set -euo pipefail

SCRIPT_NAME="opencode-bwrap"

PREFIX="${1:-${HOME}/.local}"
BINDIR="${PREFIX}/bin"
CONFIG_DIR="${HOME}/.config/opencode-bwrap"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "=========================================="
echo "Uninstalling ${SCRIPT_NAME}"
echo "=========================================="
echo ""

if [[ -f "${BINDIR}/${SCRIPT_NAME}" ]]; then
    echo "Removing: ${BINDIR}/${SCRIPT_NAME}"
    rm -f "${BINDIR}/${SCRIPT_NAME}"
    echo -e "${GREEN}✓ Script removed${NC}"
else
    echo -e "${YELLOW}! Script not found at ${BINDIR}/${SCRIPT_NAME}${NC}"
fi

echo ""
if [[ -d "${CONFIG_DIR}" ]]; then
    echo -e "${YELLOW}Configuration directory found: ${CONFIG_DIR}${NC}"
    read -p "Do you want to remove configuration files? (y/N): " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Removing: ${CONFIG_DIR}/"
        rm -rf "${CONFIG_DIR}"
        echo -e "${GREEN}✓ Configuration removed${NC}"
    else
        echo -e "${YELLOW}! Configuration kept at: ${CONFIG_DIR}${NC}"
    fi
else
    echo "Configuration directory not found (already removed or never installed)"
fi

echo ""
echo "=========================================="
echo -e "${GREEN}Uninstallation complete!${NC}"
echo "=========================================="
