# Opencode Bwrap

Sandboxed Opencode runtime using bubblewrap with configurable bind mounts.

## Quick Start

```bash
# Install
curl -fsSL https://raw.githubusercontent.com/cyunrei/opencode-bwrap/master/install-remote.sh | bash

# Run (same as opencode)
opencode-bwrap
opencode-bwrap serve
```

## Usage

`opencode-bwrap` works the same as `opencode` but runs in a sandbox.

### Add Project Paths

For security, **only configured paths are accessible**. Add your project and tool directories to `~/.config/opencode-bwrap/bwrap.conf`:

```conf
# Toolchains
bind:~/.cargo:~/.cargo
bind:~/.bun:~/.bun

# Projects
bind:~/projects:~/projects
```

Or enable quick access to current directory:
```bash
echo "bind:\$PWD:\$PWD" >> ~/.config/opencode-bwrap/bwrap.conf
```

## Installation

### Online
```bash
curl -fsSL https://raw.githubusercontent.com/cyunrei/opencode-bwrap/master/install-remote.sh | bash
```

### Local
```bash
git clone https://github.com/cyunrei/opencode-bwrap.git
cd opencode-bwrap && make install
```

### Uninstall
```bash
curl -fsSL https://raw.githubusercontent.com/cyunrei/opencode-bwrap/master/uninstall-remote.sh | bash
```

## Configuration

Config file: `~/.config/opencode-bwrap/bwrap.conf`

Format: `type:source:destination`

Types: `bind`, `ro-bind`, `bind-try`, `ro-bind-try`, `symlink`

See `bwrap.conf.example` for examples.

## Dependencies

- `bwrap` (bubblewrap)
- `opencode` (in PATH)
