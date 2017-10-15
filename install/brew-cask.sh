#!/bin/sh

# Install Caskroom

brew tap caskroom/cask
brew install brew-cask
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
  screenhero
  sketch
  skype
  slack
  spotify
  vlc
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "Installing apps..."
brew cask install "${apps[@]}"
