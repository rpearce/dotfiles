#!/bin/sh

# Check for Homebrew and install if we don't have it

if test ! $(which brew); then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brewup

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
  neovim/neovim/neovim
  postgres
  redis
  watchman
  valgrind
  vim
)

brew install ${binaries[@]}

brewup
