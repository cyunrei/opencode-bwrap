#!/usr/bin/env bash

set -o errexit -o nounset -o errtrace

# Configuration
readonly REPO="cyunrei/opencode-bwrap"
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

# Main function
main() {
	echo "=========================================="
	echo "Opencode-Bwrap Remote Uninstaller"
	echo "Repository: ${REPO}"
	echo "=========================================="
	echo ""

	local script_removed=false
	local config_removed=false

	if [[ -f "${BINDIR}/opencode-bwrap" ]]; then
		log_info "Removing: ${BINDIR}/opencode-bwrap"
		rm -f "${BINDIR}/opencode-bwrap"
		log_success "Script removed"
		script_removed=true
	else
		log_warning "Script not found at ${BINDIR}/opencode-bwrap"
	fi

	echo ""
	if [[ -d "${CONFIG_DIR}" ]]; then
		log_warning "Configuration directory found: ${CONFIG_DIR}"
		local reply
		read -p "Do you want to remove configuration files? (y/N): " -n 1 -r reply
		echo ""
		if [[ ${reply} =~ ^[Yy]$ ]]; then
			rm -rf "${CONFIG_DIR}"
			log_success "Configuration removed"
			config_removed=true
		else
			log_warning "Configuration kept at: ${CONFIG_DIR}"
		fi
	else
		log_info "Configuration directory not found"
	fi

	echo ""
	echo "=========================================="
	if [[ "${script_removed}" == true ]] || [[ "${config_removed}" == true ]]; then
		log_success "Uninstallation complete!"
	else
		log_warning "Nothing was removed"
	fi
	echo "=========================================="
}

main "${@}"
