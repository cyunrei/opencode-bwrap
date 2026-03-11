# Opencode Bwrap

Sandboxed Opencode runtime using bubblewrap with configurable bind mounts.

## Quick Start

### Install

```bash
curl -fsSL https://raw.githubusercontent.com/cyunrei/opencode-bwrap/master/install-remote.sh | bash
```

###  Run (same as opencode)

```bash
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

## Configuration

Config file: `~/.config/opencode-bwrap/bwrap.conf`

Format: `type:source:destination`

Types: `bind`, `ro-bind`, `bind-try`, `ro-bind-try`, `symlink`

See `bwrap.conf.example` for examples.

## Uninstall
```bash
curl -fsSL https://raw.githubusercontent.com/cyunrei/opencode-bwrap/master/uninstall-remote.sh | bash
```

## Dependencies

- `bwrap` (bubblewrap)
- `opencode` (in PATH)
