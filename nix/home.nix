{ pkgs, ... }:

let
  nixpkgsConfig = import ./nixpkgs/config.nix;
  user = import ./user.nix;
  xdg = import ./xdg.nix;

in {
  nixpkgs = {
    config = nixpkgsConfig;
  };

  xdg = xdg;

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

    # haskell
    cabal2nix
    haskellPackages.ghcid
    haskellPackages.hakyll
    haskellPackages.hlint
    haskellPackages.pandoc
    haskellPackages.patat
    haskellPackages.stylish-haskell
    stack

    # git
    gitAndTools.diff-so-fancy

    # apps
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

  programs.home-manager = (import ./programs/home-manager.nix { });
  programs.bash = (import ./programs/bash/default.nix { xdg = xdg; hostname = user.hostname; });
  programs.git = (import ./programs/git.nix { gitConfig = user.git; pkgs = pkgs; });
  programs.neovim = (import ./programs/neovim/default.nix { pkgs = pkgs; });

  home.file.".cabal/config".source = ../conf/cabal.cabal;
  home.file.".gemrc".source = ../conf/.gemrc;
  home.file.".ghci".source = ../conf/.ghci;
  home.file.".inputrc".source = ../conf/.inputrc;
  home.file.".psqlrc".source = ../conf/.psqlrc;
  home.file.".ripgreprc".source = ../conf/.ripgreprc;
  home.file.".stack/config.yaml".source = ../conf/stack.yaml;
  home.file.".tmux.conf".source = ../conf/.tmux.conf;
}
