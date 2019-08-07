#!/usr/bin/env bash

# Thanks to Utku Demir (https://github.com/utdemir)
# for help in general and continued inspiration!
#
# Thanks to Patrick Klingemann (https://github.com/pklingem)
# and Craig Wills (https://github.com/cdwills) for encouraging
# me to always make stuff better!

set -o errexit
#set -o nounset
set -o pipefail

# Helpers

function trace() {
  echo "! $@" >&2; $@
}

function usage() {
  cat <<EOF
Usage:
  $0 clean
  $0 help
  $0 install-home
  $0 install-work
  $0 switch-home
  $0 switch-work
EOF
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

function install() {
  # Check if ./nix/user.nix exists before we get started

  [[ -f ./nix/user.nix ]] || unknown-user

  # Keep the computer awake for the duration of this script

  [[ $(command -v caffeinate) ]] && caffeinate -dusw $$ &

  # Ask for the administrator password

  trace sudo -v

  # Nix install

  trace ./installs/nix $1

  # macOS install

  if [[ $(uname -s) == 'Darwin' ]]; then
    # Source generated ~/.profile

    trace source ~/.profile

    # Install Homebrew

    trace ./installs/homebrew $1

    # macOS-specific options

    trace ./installs/macos
  fi

  # Reload current shell

  trace exec $SHELL -l
}

function switch-to() {
  # Keep the computer awake for the duration of this script

  [[ $(command -v caffeinate) ]] && caffeinate -dusw $$ &

  # Update nix-channels and run home-manager

  trace nix-channel --update
  trace home-manager -f ./nix/$1.nix switch

  # Exec homebrew

  trace ./installs/homebrew $1
}

# Check if no command is provided

[[ $# -lt 1 ]] && unknown-cmd

# Determine command

cmd="$1"
shift

case "$cmd" in
  "clean")
    trace nix-collect-garbage --delete-older-than 30d
    trace nix optimise-store
    ;;
  "help")
    usage
    ;;
  "install-home")
    trace install home
    ;;
  "install-work")
    trace install work
    ;;
  "switch-home")
    trace switch-to home
    trace exec $SHELL -l
    ;;
  "switch-work")
    trace switch-to work
    trace exec $SHELL -l
    ;;
  *)
    unknown-cmd
    ;;
esac
