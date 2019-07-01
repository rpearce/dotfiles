{ config, pkgs, ... }:

let
  home_dir = builtins.getEnv "HOME";

in rec {
  nixpkgs.config = import ./nixpkgs/config.nix;

  xdg = {
    enable = true;
    configHome = "${home_dir}/.config";
    dataHome = "${home_dir}/Dropbox/.data";
    cacheHome = "${home_dir}/.cache";
  };

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
    ./programs/neovim/default.nix
    ./programs/git.nix
  ];

  home.file.".bash_profile".source = ../dotfiles/system/.bash_profile;
  home.file.".cabal/config".source = ../dotfiles/runcom/cabal.cabal;
  home.file.".gemrc".source = ../dotfiles/runcom/.gemrc;
  home.file.".ghci".source = ../dotfiles/runcom/.ghci;
  home.file.".psqlrc".source = ../dotfiles/runcom/.psqlrc;
  home.file.".ripgreprc".source = ../dotfiles/runcom/.ripgreprc;
  home.file.".stack/config.yaml".source = ../dotfiles/runcom/stack.yaml;
  home.file.".tmux.conf".source = ../dotfiles/runcom/.tmux.conf;
}
