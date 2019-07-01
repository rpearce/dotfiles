{ config, pkgs, ... }:

let
  home_dir = builtins.getEnv "HOME";

in rec {
  nixpkgs.config = import ./nixpkgs/config.nix;

  xdg = {
    enable = true;
    configHome = "${home_dir}/.config";
    dataHome = "${home_dir}/.data";
    cacheHome = "${home_dir}/.cache";
  };

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
    ./programs/neovim/default.nix
    ./programs/git.nix
  ];

  home.file.".bash_profile".source = ../dotfiles/system/.bash_profile;
  home.file.".gemrc".source = ../dotfiles/runcom/.gemrc;
  home.file.".psqlrc".source = ../dotfiles/runcom/.psqlrc;
  home.file.".ripgreprc".source = ../dotfiles/runcom/.ripgreprc;
}
