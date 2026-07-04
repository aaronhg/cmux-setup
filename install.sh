#!/bin/sh
set -eu

HERE=$(cd "$(dirname "$0")" && pwd)
STAMP=$(date +%Y%m%d-%H%M%S)

backup() {
  [ -f "$1" ] && cp "$1" "$1.bak-$STAMP" && echo "backed up $1 -> $1.bak-$STAMP" || true
}

if ! ls "$HOME/Library/Fonts"/FiraCode-*.ttf /Library/Fonts/FiraCode-*.ttf >/dev/null 2>&1; then
  if command -v brew >/dev/null 2>&1; then
    echo "installing Fira Code..."
    brew install --cask font-fira-code
  else
    echo "warning: Homebrew not found, install Fira Code manually: https://github.com/tonsky/FiraCode"
  fi
else
  echo "Fira Code already installed"
fi

mkdir -p "$HOME/.config/ghostty/themes"
backup "$HOME/.config/ghostty/config"
cp "$HERE/ghostty/config" "$HOME/.config/ghostty/config"
cp "$HERE/ghostty/themes/GitHub Dark Dimmed Zed" "$HOME/.config/ghostty/themes/"
echo "ghostty config and theme installed"

mkdir -p "$HOME/.config/cmux"
backup "$HOME/.config/cmux/cmux.json"
cp "$HERE/cmux/cmux.json" "$HOME/.config/cmux/cmux.json"
echo "cmux.json installed"

CMUX=$(command -v cmux || echo "/Applications/cmux.app/Contents/Resources/bin/cmux")
if [ -x "$CMUX" ] && "$CMUX" ping >/dev/null 2>&1; then
  "$CMUX" themes set --dark "GitHub Dark Dimmed Zed"
  "$CMUX" reload-config
  echo "done"
else
  echo "cmux is not running; open cmux and run:"
  echo "    cmux themes set --dark \"GitHub Dark Dimmed Zed\""
  echo "    cmux reload-config"
fi
