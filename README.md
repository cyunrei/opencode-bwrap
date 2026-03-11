# Opencode Bwrap

An isolated Opencode runtime environment using bwrap.

## Installation

### Option 1: Online Install (Recommended)

One-line install directly from GitHub:

```bash
curl -fsSL https://raw.githubusercontent.com/cyunrei/opencode-bwrap/main/install-remote.sh | bash
```

### Option 2: Clone and Install

```bash
git clone https://github.com/cyunrei/opencode-bwrap.git
cd opencode-bwrap
make install
```

By default installed to `~/.local/bin/`, you can specify a different path using `PREFIX`:

```bash
make install PREFIX=/usr/local
```

## Uninstallation

### Option 1: Online Uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/cyunrei/opencode-bwrap/main/uninstall-remote.sh | bash
```

### Option 2: Local Uninstall

```bash
make uninstall
# or
./uninstall.sh
```

## Configuration


The sandbox supports custom bind mounts through configuration files.
### Configuration File Location

```
~/.config/opencode-bwrap/bwrap.conf
```

### Configuration Format

```
# Format: type:source:destination
type:source_path:destination_path
```

Supported types:

- `bind` - Read-write bind (source must exist)
- `ro-bind` - Read-only bind (source must exist)
- `bind-try` - Read-write bind (ignored if source doesn't exist)
- `ro-bind-try` - Read-only bind (ignored if source doesn't exist)
- `symlink` - Create symbolic link

### Example Configuration

```
# Development tools
bind:~/.cargo:~/.cargo
bind:~/.rustup:~/.rustup
bind:~/.npm:~/.npm

# Project directories
ro-bind:~/Documents:~/Documents
```

See `bwrap.conf.example` for more examples.

## Base Binds

The following directories are always bound (no configuration needed):

- `~/.config/opencode`
- `~/.cache/opencode`
- `~/.local/share/opencode`
- `~/.local/state/opencode`

## Dependencies

- `bwrap` (bubblewrap)
- `opencode` (must be in PATH)
