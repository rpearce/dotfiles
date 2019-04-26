{ config, pkgs, ... }:

let
  home_dir = builtins.getEnv "HOME";

in rec {
  nixpkgs.config.allowUnfree = true;

  xdg = {
    enable = true;
    configHome = "${home_dir}/.config";
  };

  home.packages = with pkgs; [
    # CLI
    awscli
    asciinema
    bash
    bat
    coreutils
    #exercism
    findutils
    ffmpeg
    gnupg
    jq
    #perl-ack
    #openssl
    ncdu
    rename
    speedtest-cli
    tldr
    tree

    # Haskell
    #haskellPackages.hakyll
    haskellPackages.hlint
    haskellPackages.pandoc
    haskellPackages.stylish-haskell
    stack

    # Git
    git
    gitAndTools.diff-so-fancy

    # Editors
    neovim

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

  programs.home-manager = {
    enable = true;
  };
}
