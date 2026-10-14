#!/bin/bash

# quit on error
set -e 
CURRENT_DIR="${CURRENT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/macOS" && pwd)}"

WALLPAPER="$CURRENT_DIR/black.jxl"

# -------------- macOS --------------

# set macOS wallpaper
osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$WALLPAPER\""
echo "Wallpaper" $WALLPAPER "set"

# dark mode
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
echo "Dark mode on"

# -------------- Dock --------------

# dock permahide
# defaults write com.apple.dock autohide -bool true && defaults write com.apple.dock autohide-delay -float 1000 
# echo "Removed the dock"

# Dock settings

# Remove status dots
defaults write com.apple.dock show-process-indicators -bool false

# Remove downloads icon 
# defaults delete com.apple.dock persistent-others

# Disable recent apps staying on the Dock forever
defaults write com.apple.dock show-recents -bool false

# Move the Dock to the left
defaults write com.apple.dock orientation -string left

# Disable magnification
defaults write com.apple.dock magnification -bool false

# Set icon sizes
defaults write com.apple.dock largesize -int 81
defaults write com.apple.dock tilesize -int 78

# Minimized windows are kept in their icon
defaults write com.apple.dock minimize-to-application -bool true

# -------------- Miscellaneous macOS settings --------------

# No language indicator 
defaults write kCFPreferencesAnyApplication TSMLanguageIndicatorEnabled -bool false

# Don't arrange desktops by most recent
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

# Open new Finder windows in Documents folder
defaults write com.apple.finder NewWindowTargetPath -string "file:///$HOME/Documents"

# No cmd m animation
defaults write NSGlobalDomain NSWindowResizeTime .001

echo "Spring loaded folder settings"

killall Finder     

if ! [ -e "$HOME/System/Library/Fonts/Manrope.ttf" ] || [ -L "$HOME/System/Library/Fonts/Manrope.ttf" ]; then
       cp "$CURRENT_DIR/thunderbird/Manrope.ttf" "$HOME/Library/Fonts/Manrope.ttf"
fi

if ! [ -e "$HOME/System/Library/Fonts/SFMono.ttf" ] || [ -L "$HOME/System/Library/Fonts/SFMono.ttf" ]; then
       cp "$CURRENT_DIR/ghostty/SFMono.ttf" "$HOME/Library/Fonts/SFMono.ttf"
fi

if ! [ -e "$HOME/System/Library/Fonts/FantasqueMono.ttf" ] || [ -L "$HOME/System/Library/Fonts/FantasqueMono.ttf" ]; then
       cp "$CURRENT_DIR/ghostty/FantasqueMono.ttf" "$HOME/Library/Fonts/FantasqueMono.ttf"
fi


# -------------- brew --------------

if ! command -v brew &>/dev/null; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew update

curl -fsSL https://raw.githubusercontent.com/bassepeder/yabai/macos27/scripts/install-fork.sh | bash

brew bundle --file=macOS/Brewfile

# -------------- firefox --------------

FIREFOX_DIR="$HOME/Library/Application Support/Firefox"

profile="$(awk -F= '
    /^\[Install/{f=1}
    f && /^Default=/{print $2; exit}
' "$FIREFOX_DIR/profiles.ini")"

if [ -z "$profile" ]; then
    profile="$(awk -F= '
        /^\[Profile/{p=""; d=0}
        /^Path=/{p=$2}
        /^Default=1/{d=1}
        d && p{print p; exit}
    ' "$FIREFOX_DIR/profiles.ini")"
fi

FIREFOX_PROFILE="$FIREFOX_DIR/$profile"

# -------------- thunderbird --------------

THUNDERBIRD_APP="/Applications/Superhuman.app"
if [ -d "/Applications/Thunderbird.app" ]; then
    sudo mv "/Applications/Thunderbird.app" "$THUNDERBIRD_APP"
fi

THUNDERBIRD_DIR="$HOME/Library/Thunderbird"
THUNDERBIRD_PROFILE=""
if [ -f "$THUNDERBIRD_DIR/profiles.ini" ]; then
    THUNDERBIRD_PROFILE="$(awk '
        /^\[Install/ { install=1; next }
        /^\[/ { install=0 }
        install && /^Default=/ { print substr($0,9); exit }
    ' "$THUNDERBIRD_DIR/profiles.ini")"
fi

if [ -n "$THUNDERBIRD_PROFILE" ] && [ -d "$THUNDERBIRD_DIR/$THUNDERBIRD_PROFILE" ]; then
    THUNDERBIRD_PROFILE="$THUNDERBIRD_DIR/$THUNDERBIRD_PROFILE"
    echo "Using Thunderbird profile: $THUNDERBIRD_PROFILE"
else
    THUNDERBIRD_PROFILE=""
    echo "Open Superhuman once, then rerun macOS.sh to apply its profile settings."
fi

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
    "firefox/userChrome.css:$FIREFOX_PROFILE/chrome/userChrome.css"
    "firefox/userContent.css:$FIREFOX_PROFILE/chrome/userContent.css"
    "firefox/variables.css:$FIREFOX_PROFILE/chrome/variables.css"
    "firefox/navbar.css:$FIREFOX_PROFILE/chrome/navbar.css"
    "firefox/urlbar.css:$FIREFOX_PROFILE/chrome/urlbar.css"
    "firefox/tabbar.css:$FIREFOX_PROFILE/chrome/tabbar.css"
    "firefox/icons.css:$FIREFOX_PROFILE/chrome/icons.css"
    "firefox/singlerow.css:$FIREFOX_PROFILE/chrome/singlerow.css"
    "firefox/user.js:$FIREFOX_PROFILE/user.js"
)

if [ -n "$THUNDERBIRD_PROFILE" ]; then
    CONFIGS+=(
        "thunderbird/user.js:$THUNDERBIRD_PROFILE/user.js"
        "thunderbird/userChrome.css:$THUNDERBIRD_PROFILE/chrome/userChrome.css"
        "thunderbird/userContent.css:$THUNDERBIRD_PROFILE/chrome/userContent.css"
        "thunderbird/variables.css:$THUNDERBIRD_PROFILE/chrome/variables.css"
        "thunderbird/layout.css:$THUNDERBIRD_PROFILE/chrome/layout.css"
    )
fi

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

# -------------- Custom icons --------------

CUSTOM_ICONS=(
    "icns/obsidian.icns:/Applications/Obsidian.app/Contents/Resources/icon.icns:/Applications/Obsidian.app"
    "icns/mail.icns:/Applications/Superhuman.app/Contents/Resources/thunderbird.icns:/Applications/Superhuman.app"
)

for entry in "${CUSTOM_ICONS[@]}"; do
    src="${entry%%:*}"
    remainder="${entry#*:}"
    icon_path="${remainder%%:*}"
    app_path="${remainder#*:}"
    src="$CURRENT_DIR/$src"

    if [ ! -d "$app_path" ] || [ ! -f "$src" ]; then
        echo "Skipping icon for $app_path"
        continue
    fi

    if [ ! -f "$icon_path.bak" ]; then
        cp "$icon_path" "$icon_path.bak"
    fi
    cp "$src" "$icon_path"
    touch "$app_path"
    echo "Set icon for $app_path"
done

sudo rm -rf /Library/Caches/com.apple.iconservices.store
killall Dock
