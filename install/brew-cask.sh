#!/bin/sh

# Install Caskroom

brew tap caskroom/cask
brew tap caskroom/versions

# Apps
apps=(
  codekit
  dropbox
  firefox
  flux
  google-chrome
  ifunbox
  iterm2
  keka
  licecap
  psequel
  sketch
  slack
  spotify
  vlc
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "Installing apps..."
brew cask install "${apps[@]}"
