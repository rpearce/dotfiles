{ config, pkgs, ... }:

let
  home_dir = builtins.getEnv "HOME";

in rec {
  nixpkgs.config.allowUnfree = true;

  xdg = {
    enable = true;
    configHome = "${home_dir}/.config";
    dataHome = "${home_dir}/Dropbox/.data";
    cacheHome = "${home_dir}/.cache";
  };

  home.packages = with pkgs; [
    # CLI
    #ack
    asciinema
    awscli
    bash
    bat
    coreutils
    exercism
    findutils
    ffmpeg
    gnupg
    jq
    ncdu
    nix-prefetch-git
    rename
    ruby_2_6
    speedtest-cli
    tldr
    tree

    # node
    nodejs-11_x
    (yarn.override { nodejs = nodejs-11_x; })

    # Haskell
    cabal2nix
    haskellPackages.ghcid
    #haskellPackages.hakyll
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
    ../programs/home-manager.nix
    ../programs/neovim/default.nix
    ../programs/git.nix
  ];

  home.file.".ackrc".source = ../runcom/.ackrc;
  home.file.".bash_profile".source = ../runcom/.bash_profile;
  home.file.".cabal/config".source = ../cabal/config;
  home.file.".gemrc".source = ../runcom/.gemrc;
  home.file.".ghci".source = ../runcom/.ghci;
  home.file.".psqlrc".source = ../runcom/.psqlrc;
  home.file.".stack/config.yaml".source = ../stack/config.yaml;
  home.file.".tmux.conf".source = ../runcom/.tmux.conf;
}
