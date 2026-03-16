#!/usr/bin/env bash

set -o errexit -o nounset -o errtrace

# Configuration
readonly REPO="cyunrei/opencode-bwrap"
readonly BRANCH="master"
readonly BINDIR="${HOME}/.local/bin"
readonly CONFIG_DIR="${HOME}/.config/opencode-bwrap"

# Logging Subsystem
declare -g LOG_LEVEL="INFO"
declare -g -A LOG_PRIORITY=(
	["DEBUG"]=10
	["INFO"]=20
	["WARNING"]=30
	["ERROR"]=40
	["CRITICAL"]=50
)

log_color() {
	local color="${1}"
	shift
	if [[ -t 2 ]]; then
		printf "\x1b[0;%sm%s\x1b[0m\n" "${color}" "${*}" >&2
	else
		printf "%s\n" "${*}" >&2
	fi
}

log_message() {
	local color="${1}"
	local level="${2}"
	shift 2

	if [[ "${LOG_PRIORITY[${level}]}" -lt "${LOG_PRIORITY[${LOG_LEVEL}]}" ]]; then
		return 0
	fi

	log_color "${color}" "${*}"
}

log_error() { log_message 31 "ERROR" "${@}"; }
log_info() { log_message 32 "INFO" "${@}"; }
log_warning() { log_message 33 "WARNING" "${@}"; }
log_debug() { log_message 34 "DEBUG" "${@}"; }
log_success() { log_message 32 "INFO" "✓ ${*}"; }

# Dependency Check
require_command() {
	local missing=()
	for c in "${@}"; do
		if ! command -v "${c}" >/dev/null 2>&1; then
			missing+=("${c}")
		fi
	done

	if [[ ${#missing[@]} -gt 0 ]]; then
		log_error "Required command(s) not installed: ${missing[*]}"
		log_error "Please install the missing dependencies and try again"
		exit 1
	fi
}

# Download file with error handling
download_file() {
	local url="${1}"
	local output="${2}"

	if ! curl -fsSL "${url}" -o "${output}"; then
		log_error "Failed to download from: ${url}"
		return 1
	fi
}

# Main function
main() {
	echo "=========================================="
	echo "Opencode-Bwrap Remote Installer"
	echo "=========================================="
	echo ""

	log_info "Checking dependencies..."
	require_command curl bwrap opencode
	log_success "All dependencies satisfied"

	log_info "Installing from: ${REPO} (${BRANCH})"
	log_info "Install directory: ${BINDIR}"
	echo ""

	mkdir -p "${BINDIR}"
	mkdir -p "${CONFIG_DIR}"

	log_info "Downloading opencode-bwrap..."
	download_file "https://raw.githubusercontent.com/${REPO}/${BRANCH}/opencode-bwrap" "${BINDIR}/opencode-bwrap"
	chmod +x "${BINDIR}/opencode-bwrap"
	log_success "Script installed"

	log_info "Downloading example config..."
	download_file "https://raw.githubusercontent.com/${REPO}/${BRANCH}/bwrap.conf.example" "${CONFIG_DIR}/bwrap.conf.example"
	log_success "Example config installed"

	echo ""
	echo "=========================================="
	echo "Installation Summary"
	echo "=========================================="
	echo "Script: ${BINDIR}/opencode-bwrap"
	echo "Config: ${CONFIG_DIR}/bwrap.conf.example"
	echo ""

	if [[ ":${PATH}:" == *":${BINDIR}:"* ]]; then
		log_success "${BINDIR} is in your PATH"
	else
		log_warning "${BINDIR} is NOT in your PATH"
		echo ""
		echo "Add this to your shell profile (~/.bashrc, ~/.zshrc, etc.):"
		echo ""
		echo "    export PATH=\"${BINDIR}:\$PATH\""
		echo ""
		echo "Then reload: source ~/.bashrc"
	fi

	echo ""
	log_success "Installation complete!"
	echo ""
	echo "Usage:"
	echo "    opencode-bwrap [args...]"
	echo ""
	echo "Configure binds by creating:"
	echo "    ${CONFIG_DIR}/bwrap.conf"
}

main "${@}"
