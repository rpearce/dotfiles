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
  haskell-platform
  keka
  ifunbox
  iterm2
  licecap
  nylas-n1
  psequel
  screenhero
  skype
  sketch
  slack
  spotify
  virtualbox
  vlc
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "Installing apps..."
brew cask install "${apps[@]}"
