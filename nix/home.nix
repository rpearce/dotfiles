{ config, pkgs, ... }:

{
  nixpkgs.config = import ./nixpkgs/config.nix;

  xdg = import ./xdg.nix;

  home.packages = with pkgs; [
    # CLI
    asciinema
    bash
    bat
    coreutils
    exercism
    findutils
    ffmpeg
    gnupg
    heroku
    jq
    ncdu
    nix-prefetch-git
    patat
    rename
    ripgrep
    ruby_2_6
    speedtest-cli
    tldr
    timetrack-cli
    tree

    # node
    nodejs-12_x
    (yarn.override { nodejs = nodejs-12_x; })

    # Haskell
    cabal2nix
    haskellPackages.ghcid
    haskellPackages.hakyll
    haskellPackages.hlint
    haskellPackages.pandoc
    haskellPackages.stylish-haskell
    stack

    # Git
    gitAndTools.diff-so-fancy

    # Apps
    #docker
    #dropbox
    #firefox
    #google-chrome
    #iterm2
    #psequel
    #sketch
    #slack
    #spotify
    #vlc
  ];

  imports = [
    ./programs/home-manager.nix
    ./programs/bash/default.nix
    ./programs/neovim/default.nix
    ./programs/git.nix
  ];

  home.file.".cabal/config".source = ../conf/cabal.cabal;
  home.file.".gemrc".source = ../conf/.gemrc;
  home.file.".ghci".source = ../conf/.ghci;
  home.file.".psqlrc".source = ../conf/.psqlrc;
  home.file.".ripgreprc".source = ../conf/.ripgreprc;
  home.file.".stack/config.yaml".source = ../conf/stack.yaml;
  home.file.".tmux.conf".source = ../conf/.tmux.conf;
}
