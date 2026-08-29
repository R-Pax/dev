#!/bin/bash

# quit on error
set -e 

# -------------- macOS --------------

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

killall Dock Finder     

# -------------- brew --------------

if ! command -v brew &>/dev/null; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew update

brew trust --formula koekeishiya/formulae/yabai

brew bundle --file=Brewfile
