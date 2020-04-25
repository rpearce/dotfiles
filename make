#!/usr/bin/env bash

set -o errexit
#set -o nounset
set -eou pipefail

# Helpers

function trace() {
  echo "! $@" >&2; $@
}

function usage() {
  cat <<EOF
Usage:
  $0 clean           (-d)
  $0 help            (-h|--help)
  $0 install-home    (ihome)
  $0 install-work    (iwork)
  $0 news-home       (nhome)
  $0 news-work       (nwork)
  $0 switch-home     (home)
  $0 switch-work     (work)
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
    # Source generated ~/.profile or ~/.zprofile

    [[ -f ~/.profile ]] && source ~/.profile
    [[ -f ~/.zprofile ]] && source ~/.zprofile

    # Install Homebrew

    trace ./installs/homebrew $1

    # macOS-specific options

    trace ./installs/macos
  fi

  # Reload current shell

  trace exec $SHELL -l
}

function news() {
  trace home-manager -f ./nix/$1.nix news
}

function switch-to() {
  # Keep the computer awake for the duration of this script

  [[ $(command -v caffeinate) ]] && caffeinate -dusw $$ &

  # Update nix-channels and run home-manager

  trace nix-channel --update
  trace home-manager -f ./nix/$1.nix switch

  # Exec homebrew

  trace ./installs/homebrew $1

  # Reload current shell

  trace exec $SHELL -l
}

# Check if no command is provided

[[ $# -lt 1 ]] && unknown-cmd

# Determine command

cmd="$1"
shift

case "$cmd" in
  clean|-d)
    trace nix-collect-garbage --delete-older-than 7d
    trace nix optimise-store
    ;;
  help|-h|--help)
    usage
    ;;
  install-home|ihome)
    trace install home
    ;;
  install-work|iwork)
    trace install work
    ;;
  news-home|nhome)
    trace news home
    ;;
  news-work|nwork)
    trace news work
    ;;
  switch-home|home)
    trace switch-to home
    ;;
  switch-work|work)
    trace switch-to work
    ;;
  *)
    unknown-cmd
    ;;
esac
