# cmux terminal setup

Tested with cmux 0.64.17.

## Prerequisites

- [cmux](https://cmux.com) installed
- Homebrew (used to install the Fira Code font; skip if the font is already installed)

## Install

```sh
sh install.sh
```

The script installs Fira Code if missing, copies the config files into place
(backing up existing ones as `*.bak-<timestamp>`), applies the theme, and
reloads cmux.

If cmux is not running when the script finishes, open cmux and run:

```sh
cmux themes set --dark "GitHub Dark Dimmed Zed"
cmux reload-config
```
