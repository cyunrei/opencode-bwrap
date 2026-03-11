# Opencode Bwrap

An isolated Opencode runtime environment using bwrap.

## Installation

```bash
make install
```

By default installed to `~/.local/bin/`, you can specify a different path using `PREFIX`:

```bash
make install PREFIX=/usr/local
```

## Uninstallation

```bash
make uninstall
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
