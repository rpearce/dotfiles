#!/usr/bin/env bash

# Thanks to Utku Demir (https://github.com/utdemir)
# for help in general and continued inspiration!
#
# Thanks to Patrick Klingemann (https://github.com/pklingem)
# and Craig Wills (https://github.com/cdwills) for pushing
# me to always make stuff like this better!

set -o errexit
set -o nounset
set -o pipefail

function trace() {
  echo "! $@" >&2; $@
}

function usage() {
cat <<EOF
Usage:
  $0 clean
  $0 help
  $0 home
  $0 install
  $0 work
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

  trace . "$XDG_CONFIG_HOME/installs/nix"

  # macOS install

  if [[ $(uname -s) == 'Darwin' ]]; then
    if [[ -z "$(xcode-select -p)" ]]; then
      echo "Either XCode isn't installed or isn't linked. Install it, or link with xcode-select."
      exit 1
    fi

    trace . "$XDG_CONFIG_HOME/installs/homebrew"
    trace . "$XDG_CONFIG_HOME/installs/stack"
    trace . "$XDG_CONFIG_HOME/installs/macos"
  fi
}

function switch-to() {
  trace nix-channel --update
  trace home-manager -f $XDG_CONFIG_HOME/nix/$1.nix switch
}

[[ $# -lt 1 ]] && unknown-cmd

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
  "home")
    switch-to home
    ;;
  "install")
    trace install
    ;;
  "work")
    switch-to work
    ;;
  *)
    unknown-cmd
    ;;
esac
