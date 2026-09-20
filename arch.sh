#!/bin/bash 

# quit on error
set -e 

CURRENT_DIR="${CURRENT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/arch" && pwd)}"

# ------------- brew --------------

if ! command -v brew &>/dev/null; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew update

# -------------- Set up configs --------------

PROTECTED_CONFIGS=(
	"hypr/hyprland.conf:$HOME/.config/hypr/hyprland.conf"
)

CONFIGS=(
	"hypr/hyprland.conf:$HOME/.config/hypr/hyprland.conf"
	"git/.gitconfig:$HOME/.gitconfig"
	"zsh/.zshrc:$HOME/.zshrc"
	"foot/foot.ini:$HOME/.config/foot/foot.ini"
	"tmux/.tmux.conf:$HOME/.tmux.conf"
)

for entry in "${CONFIGS[@]}"; do
   src="${entry%%:*}"
   dest="${entry##*:}"
   mkdir -p "$(dirname "$dest")"

   if [[ -e "$dest" && ! ( " ${PROTECTED_CONFIGS[*]} " == *" $config "* ) && ! -L "$dest" ]]; then
        rm -rf "$dest"
   fi

   ln -sf "$CURRENT_DIR/$src" "$dest"

   if [ -L "$dest" ]; then
     echo "OK   $dest -> $(readlink "$dest")"
   elif [ -e "$dest" ]; then
     echo "! $dest exists but is NOT a symlink"
   else
     echo "ERROR $dest does not exist"
 fi
done
