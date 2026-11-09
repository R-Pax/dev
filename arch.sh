#!/bin/bash 

# quit on error
set -e 

CURRENT_DIR="${CURRENT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/arch" && pwd)}"

# Downloads
sudo dnf install -y \
  git \
  zsh \
  tmux \
  shairport-sync \
  avahi-daemon

# Symlinks

CONFIGS=(
	"git/.gitconfig:$HOME/.gitconfig"
	"zsh/.zshrc:$HOME/.zshrc"
	"tmux/.tmux.conf:$HOME/.tmux.conf"
	"nvim:$HOME/.config/nvim"
    "kitty/kitty.conf:$HOME/.config/kitty/kitty.conf"
)

for entry in "${CONFIGS[@]}"; do
   src="${entry%%:*}"
   dest="${entry##*:}"
   mkdir -p "$(dirname "$dest")"

   ln -sf "$CURRENT_DIR/$src" "$dest"

   if [ -L "$dest" ]; then
     echo "OK   $dest -> $(readlink "$dest")"
   elif [ -e "$dest" ]; then
     echo "! $dest exists but is NOT a symlink"
   else
     echo "ERROR $dest does not exist"
 fi
done
