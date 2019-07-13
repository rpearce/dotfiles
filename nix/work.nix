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
    findutils
    gnupg
    jq
    ncdu
    nix-prefetch-git
    openvpn
    rename
    ripgrep
    ruby_2_6
    speedtest-cli
    tldr
    tree

    # node
    nodejs-12_x
    (yarn.override { nodejs = nodejs-12_x; })

    # git
    gitAndTools.diff-so-fancy
  ];

  programs.home-manager = (import ./programs/home-manager.nix { });
  programs.bash = (import ./programs/bash/default.nix { xdg = xdg; hostname = user.hostname; });
  programs.git = (import ./programs/git.nix { gitConfig = user.git; pkgs = pkgs; });
  programs.neovim = (import ./programs/neovim/default.nix { pkgs = pkgs; });

  home.file.".gemrc".source = ../conf/.gemrc;
  home.file.".inputrc".source = ../conf/.inputrc;
  home.file.".psqlrc".source = ../conf/.psqlrc;
  home.file.".ripgreprc".source = ../conf/.ripgreprc;
}
