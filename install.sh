#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"

link() {
  local src="$1"
  local dest="$2"

  # 既存があれば退避（ディレクトリでもファイルでも）
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    echo "backup: $dest -> ${dest}.bak"
    rm -rf "${dest}.bak" 2>/dev/null || true
    mv "$dest" "${dest}.bak"
  fi

  echo "link: $dest -> $src"
  ln -s "$src" "$dest"
}

# NeoVim（AppData/Local/nvim を丸ごと）
mkdir -p "$HOME/AppData/Local"
link "$ROOT/nvim" "$HOME/AppData/Local/nvim"

# WezTerm
link "$ROOT/wezterm/wezterm.lua" "$HOME/.wezterm.lua"

# Starship
mkdir -p "$HOME/.config"
link "$ROOT/starship/starship.toml" "$HOME/.config/starship.toml"

# Git Bash
link "$ROOT/bash/bashrc" "$HOME/.bashrc"
link "$ROOT/bash/bash_profile" "$HOME/.bash_profile"
