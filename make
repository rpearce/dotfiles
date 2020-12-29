#!/bin/bash

set -o errexit
set -o errtrace
set -o nounset
set -eou pipefail

function clean {
  nix-collect-garbage -d
  nix optimise-store
}

function brewup {
  local brew_path="$BREWFILE_PATH"

  if [ -n "$brew_path" ]; then
    brew bundle cleanup -f --file="$brew_path"
    brew bundle -v --file="$brew_path"
    brew update
    brew upgrade
    brew upgrade --cask
    brew cleanup
    brew doctor
  else
    echo "INFO: No BREWFILE_PATH specified. brewup was not ran."
  fi

  return 0
}

function hm {
  # Keep the computer awake for the duration of this script

  kaffe

  # Run home-manager with whatever options were sent

  nix-shell --run "home-manager $*"

  # Reload current shell

  exec "$SHELL" -l
}

function setup {
  # Check if ./nix/user.nix exists before we get started

  [[ -f ./nix/user.nix ]] || unknown-user

  # Keep the computer awake for the duration of this script

  kaffe

  # Ask for the administrator password

  echo "Getting sudo permission up-front for any tools that require it..."
  sudo -v

  # Nix

  ./nix/install_nix
  switch

  # Source generated ~/.profile or ~/.zprofile

  # shellcheck source=/dev/null
  [[ -f ~/.profile ]] && source ~/.profile

  # shellcheck source=/dev/null
  [[ -f ~/.zprofile ]] && source ~/.zprofile

  # macOS

  if [[ $(uname -s) == 'Darwin' ]]; then
    # Homebrew

    ./homebrew/install_homebrew
    brewup

    # macOS-specific options

    ./misc/macos
  fi

  # Reload current shell

  exec "$SHELL" -l
}

function kaffe {
  [[ $(command -v caffeinate) ]] && caffeinate -dusw $$ &
}

function switch {
  local hm_cfg_path="$HOME_MANAGER_CONFIG"

  kaffe

  if [ -n "$hm_cfg_path" ]; then
    nix-shell --run "home-manager switch -f '$hm_cfg_path'"
  else
    echo "INFO: No HOME_MANAGER_CONFIG specified. Using $PWD/nix/home.nix, instead."
    nix-shell --run "home-manager switch"
  fi

  return 0
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
  switch
  brewup
}

function usage() {
  cat <<EOF
Usage: ./make <COMMAND>
  clean     (-d)           Collect nix garbage and optimise the store
  brewup                   Run brew commands using BREWFILE_PATH
  help      (-h|--help)    Read this usage
  hm                       Run home-manager with commands
  setup                    Install nix, run home-manager, install homebrew, load
                           your Brewfile, load macOS-specific options
  switch                   Run home-manager switch HOME_MANAGER_CONFIG
  update                   Update dependencies
EOF
  return 0
}

# Check if no command is provided

[[ $# -lt 1 ]] && unknown-cmd

# Load ENV vars

# shellcheck source=./env
[[ -f "$PWD/env" ]] && . "$PWD/env"

# Determine command

cmd="$1"
shift

case "$cmd" in
        clean|-d) clean;;
          brewup) brewup;;
  help|-h|--help) usage;;
              hm) hm "$@";;
           setup) setup;;
          switch) switch;;
          update) update;;
               *) unknown-cmd;;
esac
