#!/bin/bash

# quit on error
set -e 

# -------------- macOS --------------

# dark mode
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# dock permahide
defaults write com.apple.dock autohide -bool true && defaults write com.apple.dock autohide-delay -float 1000 && killall Dock

# square windows
defaults write -g NSConvolutionOverride1 -float 0.1 && killall Finder

# no auto correct 
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# finder no filename extensions/popups
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
