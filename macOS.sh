#!/bin/bash

# quit on error
set -e 

CURRENT_DIR="${CURRENT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/macOS" && pwd)}"

WALLPAPER="$CURRENT_DIR/black.png"

# -------------- macOS --------------

# set macOS wallpaper
osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$WALLPAPER\""
echo "Wallpaper" $WALLPAPER "set"

# dark mode
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
echo "Dark mode on"

# dock permahide
defaults write com.apple.dock autohide -bool true && defaults write com.apple.dock autohide-delay -float 1000 
echo "Removed the dock"

# dock settings if I ever want it back 
defaults write com.apple.dock orientation -string left
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -int 81
defaults write com.apple.dock tilesize -int 78
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock mru-spaces -bool false

# square windows
defaults write -g NSConvolutionOverride1 -float 0.1 
echo "Windows are now squared off"

# no auto correct 
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
echo "Auto correct is off"

# Finder popups
defaults write com.apple.finder WarnOnEmptyTrash -bool false
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Show/hide files
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder UI
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string Nlsv

# Menu bar
defaults write NSGlobalDomain AppleMenuBarFontSize -string large
echo "Big menu bar"

# Mouse
defaults write NSGlobalDomain com.apple.mouse.linear -int 1
defaults write NSGlobalDomain com.apple.mouse.scaling -float 0.5
echo "Set up mouse"

# Sounds
defaults write NSGlobalDomain com.apple.sound.beep.volume -int 0
defaults -currentHost write com.apple.notificationcenterui doNotDisturb -bool true
killall NotificationCenter

# Folders
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
defaults write NSGlobalDomain com.apple.springing.delay -float 0.5
defaults write com.apple.finder "FXRemoveOldTrashItems" -bool true
echo "Spring loaded folder settings"

killall Dock Finder     

# -------------- brew --------------

if ! command -v brew &>/dev/null; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew update

brew trust --formula koekeishiya/formulae/yabai

brew bundle --file=macOS/Brewfile

# -------------- Set up configs --------------

CONFIGS=(
    "zsh/.zshrc:$HOME/.zshrc"
    "yabai/yabairc:$HOME/.yabairc"
    "yabai/skhdrc:$HOME/.config/skhd/skhdrc"
    "ghostty/config.ghostty:$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"
    "nvim:$HOME/.config/nvim"
    "git/.gitconfig:$HOME/.gitconfig"
    "git/.gitignore_global:$HOME/.gitignore_global" 
    "tmux/.tmux.conf:$HOME/.tmux.conf"
)

for entry in "${CONFIGS[@]}"; do
   src="${entry%%:*}"
   dest="${entry##*:}"
   mkdir -p "$(dirname "$dest")"

   if [ -e "$dest" ] || [ -L "$dest" ]; then
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
