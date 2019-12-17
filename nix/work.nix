{ pkgs, ...  }:

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
    awscli
    bash
    bash-completion
    bat
    coreutils
    ctop
    findutils
    gnupg
    jq
    ncdu
    openvpn
    rename
    ripgrep
    ruby_2_6
    speedtest-cli
    tldr
    tree
    watchman
    zsh-completions

    # node
    nodejs-12_x
    (yarn.override { nodejs = nodejs-12_x; })
    #nodePackages.node2nix

    # git
    git-lfs
    gitAndTools.diff-so-fancy
    nix-prefetch-git
  ];

  programs.home-manager = (import ./programs/home-manager.nix { });
  programs.zsh = (import ./programs/zsh/default.nix { xdg = xdg; hostname = user.hostname; });
  programs.git = (import ./programs/git.nix { gitConfig = user.git; pkgs = pkgs; });
  programs.neovim = (import ./programs/neovim/default.nix { pkgs = pkgs; });

  home.file.".gemrc".source = ../conf/.gemrc;
  home.file.".inputrc".source = ../conf/.inputrc;
  home.file.".psqlrc".source = ../conf/.psqlrc;
  home.file.".ripgreprc".source = ../conf/.ripgreprc;
}
