#!/bin/bash

# Dock
defaults write com.apple.dock autohide -bool true && defaults write com.apple.dock autohide-delay -float 1000 && killall Dock
