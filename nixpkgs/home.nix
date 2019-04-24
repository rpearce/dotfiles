{ config, pkgs, ... }:

{
  home.packages = [
    # CLI
    pkgs.awscli
    pkgs.asciinema
    pkgs.bash
    pkgs.bat
    pkgs.exercism
    pkgs.findutils
    pkgs.git
    pkgs.gitAndTools.diff-so-fancy
    pkgs.jq
    #pkgs.perl-ack
    pkgs.ncdu
    pkgs.neovim
    pkgs.rename
    pkgs.speedtest-cli
    pkgs.stack
    pkgs.tldr
    pkgs.tree
    pkgs.vim
  ];

  programs.git = {
    enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager = {
    enable = true;
  };
}
