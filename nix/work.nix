{ config, pkgs, ... }:

{
  nixpkgs.config = import ./nixpkgs/config.nix;

  xdg = import ./xdg.nix;

  home.packages = with pkgs; [
    # CLI
    asciinema
    awscli
    bash
    bat
    coreutils
    findutils
    gnupg
    jq
    ncdu
    nix-prefetch-git
    rename
    ripgrep
    ruby_2_6
    speedtest-cli
    tldr
    tree

    # node
    nodejs-12_x
    (yarn.override { nodejs = nodejs-12_x; })

    # Git
    gitAndTools.diff-so-fancy
  ];

  imports = [
    ./programs/home-manager.nix
    ./programs/bash/default.nix
    ./programs/neovim/default.nix
    ./programs/git.nix
  ];

  home.file.".gemrc".source = ../conf/.gemrc;
  home.file.".psqlrc".source = ../conf/.psqlrc;
  home.file.".ripgreprc".source = ../conf/.ripgreprc;
}
