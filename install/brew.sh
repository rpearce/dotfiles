#!/bin/sh

# Check for Homebrew and install if we don't have it

if test ! $(which brew); then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew upgrade
brew cleanup
brew prune
brew doctor

# Install Terminal Utils

binaries=(
  coreutils # Install GNU core utilities (those that come with OS X are outdated)
  findutils # Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
  bash # Install Bash 4
  python
  ack
  git
  hub
  rbenv
  ruby-build
  erlang
  elixir
  heroku-toolbelt
  neovim
  postgres
  redis
  speedtest-cli
  watchman
  valgrind
  vim
)

brew install ${binaries[@]}

brew update
brew upgrade
brew cleanup
brew prune
brew doctor
