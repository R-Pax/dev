#!/bin/bash 

# quit on error
set -e 

# Create fonts dir
mkdir -p "$HOME/.local/share/fonts/"

CURRENT_DIR="${CURRENT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/arch" && pwd)}"

# Downloads

sudo dnf copr enable imput/helium 
dnf copr enable lionheartp/Hyprland

sudo dnf in -y \
  git \
  zsh \
  tmux \
  nvim \
  shairport-sync \
  avahi-daemon \
  helium-bin \
  noctalia-hyprland-meta

# Fonts

cp -n "$HOME/Documents/dev/Fonts/SFMono.ttf" "$HOME/.local/share/fonts/SFMono.ttf"
cp -n "$HOME/Documents/dev/Fonts/FantasqueMono.ttf" "$HOME/.local/share/fonts/FantasqueMono.ttf"

# Symlinks

CONFIGS=(
	"git/.gitconfig:$HOME/.gitconfig"
	"zsh/.zshrc:$HOME/.zshrc"
	"tmux/.tmux.conf:$HOME/.tmux.conf"
	"nvim:$HOME/.config/nvim"
    "kitty/kitty.conf:$HOME/.config/kitty/kitty.conf"
    "AirPlay/shairport-sync.conf:/etc/shairport-sync.conf"
)

for entry in "${CONFIGS[@]}"; do
   src="${entry%%:*}"
   dest="${entry##*:}"
   mkdir -p "$(dirname "$dest")"

   sudo ln -sf "$CURRENT_DIR/$src" "$dest"

   if [ -L "$dest" ]; then
     echo "OK   $dest -> $(readlink "$dest")"
   elif [ -e "$dest" ]; then
     echo "! $dest exists but is NOT a symlink"
   else
     echo "ERROR $dest does not exist"
 fi
done

# Hyprland doesn't like symlinks

COPIES=(
	"hypr/hyprland.lua:$HOME/.config/hypr/hyprland.lua"
)

for entry in "${COPIES[@]}"; do
	src="${entry%%:*}"
	dest="${entry##*:}"
	mkdir -p "$(dirname "$dest")"

	cp "$CURRENT_DIR/$src" "$dest"

	if [ -f "$dest" ]; then
		echo "OK   $dest (copied)"
	else
		echo "ERROR failed to copy $dest"
	fi
done

# Set zsh as default shell
chsh -s /bin/zsh

