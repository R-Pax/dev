#!/bin/bash

# quit on error
set -e 

# -------------- macOS --------------

# dark mode
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
echo "Dark mode on"

# dock permahide
defaults write com.apple.dock autohide -bool true && defaults write com.apple.dock autohide-delay -float 1000 && killall Dock
echo "Removed the dock"

# square windows
defaults write -g NSConvolutionOverride1 -float 0.1 && killall Finder
echo "Windows are now squared off"

# no auto correct 
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
echo "Auto correct is off"

# finder no filename extensions/popups
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

killall dock killall Finder     

# -------------- brew --------------

if ! command -v brew &>/dev/null; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew update

brew trust --formula koekeishiya/formulae/yabai

brew bundle --file=Brewfile
