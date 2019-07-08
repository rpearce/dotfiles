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
}

function unknown-cmd() {
  echo "I'm not sure what you want me to do!"
  usage
  return 1
}

function install() {
  # Keep the computer awake for the duration of this script.

  [[ $(command -v caffeinate) ]] && caffeinate -dusw $$ &

  # Ask for the administrator password

  trace sudo -v

  # sudo keep-alive

  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

  # Nix install

  trace . ./installs/nix
  trace switch-to $1

  # macOS install

  if [[ $(uname -s) == 'Darwin' ]]; then
    # Source generated ~/.profile

    . ~/.profile

    # Install Homebrew

    trace ./installs/homebrew || true

    # macOS-specific options

    trace ./installs/macos || true
  fi

  # Reload current shell

  trace exec $SHELL -l
}

function switch-to() {
  trace nix-channel --update
  trace home-manager -f ./nix/$1.nix switch
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
    ;;
  "switch-work")
    trace switch-to work
    ;;
  *)
    unknown-cmd
    ;;
esac
