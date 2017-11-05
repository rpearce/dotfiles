#!/bin/sh

# Install Caskroom

brew tap caskroom/cask
brew tap caskroom/versions

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "Installing apps..."

brew cask install codekit
brew cask install dropbox
brew cask install firefox
brew cask install flux
brew cask install google-chrome
brew cask install ifunbox
brew cask install iterm2
brew cask install keka
brew cask install licecap
brew cask install psequel
brew cask install sketch
brew cask install slack
brew cask install spotify
brew cask install vlc