#!/bin/bash

set -o errexit
set -o errtrace
set -o nounset
set -eou pipefail

function clean {
  nix-collect-garbage --delete-older-than 7d
  nix optimise-store
}

function setup {
  # Check if ./nix/user.nix exists before we get started

  [[ -f ./nix/user.nix ]] || unknown-user

  # Keep the computer awake for the duration of this script

  [[ $(command -v caffeinate) ]] && caffeinate -dusw $$ &

  # Ask for the administrator password

  sudo -v

  # Install Nix

  ./nix/install_nix

  # @TODO: switch here

  # Source generated ~/.profile or ~/.zprofile

  # shellcheck source=/dev/null
  [[ -f ~/.profile ]] && source ~/.profile

  # shellcheck source=/dev/null
  [[ -f ~/.zprofile ]] && source ~/.zprofile

  # macOS

  if [[ $(uname -s) == 'Darwin' ]]; then
    # Homebrew

    ./homebrew/install_homebrew
    brew bundle cleanup -f --file="./homebrew/$1/Brewfile"
    brew bundle -v --file="./homebrew/$1/Brewfile"
    brew update
    brew upgrade
    brew cleanup
    brew doctor
    brew cask upgrade

    # macOS-specific options

    ./misc/macos
  fi

  # Reload current shell

  exec "$SHELL" -l
}

function switch {
  [[ $(command -v caffeinate) ]] && caffeinate -dusw $$ &

  nix-shell --run "home-manager switch $*"

  exec "$SHELL" -l
}

function unknown-cmd() {
  echo "I'm not sure what you want me to do!"
  usage
  return 1
}

function unknown-user() {
  echo "File is missing: $(pwd)/nix/user.nix"
  echo "Try running 'cp -n $(pwd)/nix/user{.example,}.nix' and filling out your information"
  return 1
}

function update {
  nix-shell --run "niv update"
}

function usage() {
  cat <<EOF
Usage: $0 <COMMAND>
  clean     (-d)
  help      (-h|--help)
  setup     <home|work>
  switch
  update
EOF
  return 0
}

# Check if no command is provided

[[ $# -lt 1 ]] && unknown-cmd

# Determine command

cmd="$1"
shift

case "$cmd" in
        clean|-d) clean;;
  help|-h|--help) usage;;
           setup) setup "${1:-home}";;
          switch) switch "$@";;
          update) update;;
               *) unknown-cmd;;
esac
