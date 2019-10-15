{ pkgs, ... }:

let
  nixpkgsConfig = import ./nixpkgs/config.nix;
  user = import ./user.nix;
  xdg = import ./xdg.nix;
  all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};

in {
  nixpkgs = {
    config = nixpkgsConfig;
  };

  xdg = xdg;

  home.packages = with pkgs; [
    # CLI
    asciinema
    bash
    bash-completion
    bat
    cachix
    coreutils
    ctop
    exercism
    findutils
    ffmpeg
    gnupg
    heroku
    jq
    ncdu
    rename
    ripgrep
    ruby_2_6
    speedtest-cli
    tldr
    timetrack-cli
    tree
    zsh-completions

    # node
    nodejs-12_x
    (yarn.override { nodejs = nodejs-12_x; })
    nodePackages.node2nix

    # haskell
    cabal2nix
    haskellPackages.ghcid
    haskellPackages.hakyll
    haskellPackages.hlint
    haskellPackages.hoogle
    haskellPackages.pandoc
    #haskellPackages.patat
    haskellPackages.stylish-haskell
    stack
    (all-hies.selection { selector = p: { inherit (p) ghc865; }; })

    # git
    gitAndTools.diff-so-fancy
    nix-prefetch-git
  ];

  programs.home-manager = (import ./programs/home-manager.nix { });
  programs.zsh = (import ./programs/zsh/default.nix { xdg = xdg; hostname = user.hostname; });
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
