# 🪴 my dotfile garden 🌱

Welcome! I use this repository as my automated way to setup machines with my
specific preferences.

## Current setup

* Install scripts are broken into 3 environments:
  1. `./install` for my personal machine
  1. `./install-work` for my work machine
* Uses the [XDG spec](https://wiki.archlinux.org/title/XDG_Base_Directory) to
  attempt to prevent cluttering the `$HOME` (`~`) folder
* Symlinks config files from this project to where they are expected to be found
* Uses [Homebrew Bundle Brewfiles](https://github.com/Homebrew/homebrew-bundle)
  to download CLI tools and GUI applications
* Uses the latest `zsh` and has that work with `tmux`
* Sets plenty of system preferences, including DNS servers and remapping the
  caps lock to be control
* SSH setup
* Installs [nix](https://nixos.org), [cachix](https://www.cachix.org), and
  [devenv](https://devenv.sh)
* More little things...

## Historical

In the past I've used these tools to manage my machines:

* [nix-darwin](https://github.com/LnL7/nix-darwin/)
* [home-manager](https://github.com/nix-community/home-manager)

Here is this dotfile garden's [first
commit](https://github.com/rpearce/dotfiles/commit/5f5d46a2d2d0155011a77a12076677fd769120d5).

## Disclaimer

This is not intended to be used as a template, but it may provide inspiration
for those looking to craft their own dotfiles and learn a few things along the
way.
