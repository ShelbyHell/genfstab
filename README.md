# genfstab

Standalone repository for `genfstab`, extracted from Arch Linux's [arch-install-scripts](https://gitlab.archlinux.org/archlinux/arch-install-scripts).

`genfstab` helps fill in an `/etc/fstab` file by autodetecting all current mounts below a given mountpoint and printing them in an `fstab`-compatible format to standard output.

---

## Requirements

### Runtime
- `bash` (with `extglob` support)
- `util-linux` (`findmnt`, `lsblk`, `mountpoint`)
- `coreutils` (`realpath`)

### Build time
- `make`
- `m4`
- `asciidoc` / `a2x` *(optional, needed only to regenerate `doc/genfstab.8` from asciidoc source)*

---

## Building and Testing

Build the `genfstab` executable:
```bash
make
```

Run test suite:
```bash
make check
```

---

## Installation

Default prefix is `/usr/local`. To install system-wide:
```bash
sudo make install
```

Or with a custom prefix:
```bash
sudo make PREFIX=/usr install
```

This installs:
- Binary: `$PREFIX/bin/genfstab`
- Bash completions: `$PREFIX/share/bash-completion/completions/genfstab`
- Zsh completions: `$PREFIX/share/zsh/site-functions/_genfstab`
- Manpage: `$PREFIX/share/man/man8/genfstab.8`

---

## Usage

Generate fstab using UUIDs:
```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

Generate fstab using labels:
```bash
genfstab -L /mnt >> /mnt/etc/fstab
```

Include pseudo-filesystems (proc, sysfs, devtmpfs, etc.):
```bash
genfstab -U -P /mnt >> /mnt/etc/fstab
```

Command-line help:
```
usage: genfstab [options] root

  Options:
    -f <filter>    Restrict output to mountpoints matching the prefix FILTER
    -L             Use labels for source identifiers (shortcut for -t LABEL)
    -p             Exclude pseudofs mounts (default behavior)
    -P             Include pseudofs mounts
    -t <tag>       Use TAG for source identifiers (TAG should be one of: LABEL,
                      UUID, PARTLABEL, PARTUUID)
    -U             Use UUIDs for source identifiers (shortcut for -t UUID)

    -h             Print this help message
```

---

## License

GPL-2.0-only (see [COPYING](COPYING)).
