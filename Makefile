# opencode sandbox wrapper Makefile

PREFIX ?= $(HOME)/.local
BINDIR = $(PREFIX)/bin

SCRIPT = opencode-bwrap
CONFIG = bwrap.conf.example
CONFIG_DIR = $(HOME)/.config/opencode-bwrap

.PHONY: all install uninstall

all:
	@echo "Usage: make install [PREFIX=path]"
	@echo "  Default PREFIX: $(HOME)/.local"
	@echo "  Installs as: $(SCRIPT)"

install:
	@echo "Installing $(SCRIPT) to $(BINDIR)..."
	@mkdir -p $(BINDIR)
	@install -m 755 $(SCRIPT) $(BINDIR)/$(SCRIPT)
	@echo "Installing config to $(CONFIG_DIR)..."
	@mkdir -p $(CONFIG_DIR)
	@install -m 644 $(CONFIG) "$(CONFIG_DIR)/bwrap.conf.example"
	@echo "Config installed: $(CONFIG_DIR)/bwrap.conf.example"
	@echo "Installation complete!"
	@echo "Make sure $(BINDIR) is in your PATH"

uninstall:
	@echo "Removing $(SCRIPT) from $(BINDIR)..."
	@rm -f $(BINDIR)/$(SCRIPT)
	@echo "Uninstallation complete!"
