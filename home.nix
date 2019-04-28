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
    nodejs-11_x
    rename
    ruby_2_6
    speedtest-cli
    tldr
    tree
    yarn

    # Haskell
    cabal2nix
    haskellPackages.ghcid
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
    path = "${xdg.configHome}/home.nix";
  };

  home.file.".ackrc".source = ./runcom/.ackrc;
  home.file.".bash_profile".source = ./runcom/.bash_profile;
  home.file.".gemrc".source = ./runcom/.gemrc;
  home.file.".ghci".source = ./runcom/.ghci;
  home.file.".nvimrc".source = ./runcom/.nvimrc;
  home.file.".psqlrc".source = ./runcom/.psqlrc;
  home.file.".tmux.conf".source = ./runcom/.tmux.conf;
  home.file.".stack/config.yml".source = ./stack/config.yml;
}
