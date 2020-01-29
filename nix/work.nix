{ config, pkgs, ... }:

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
    #asciinema
    awscli
    bash
    bash-completion
    bat
    coreutils
    ctop
    findutils
    fswatch
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
    nodejs-13_x
    (yarn.override { nodejs = nodejs-13_x; })
    nodePackages.node2nix

    # elixir
    elixir

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

  # NPM config options in lieu of no easy static config file
  home.activation.setNpmOptions =
    let
      npmSet = "$DRY_RUN_CMD ${pkgs.nodejs-13_x}/bin/npm set";
    in
      config.lib.dag.entryAfter ["writeBoundary"] ''
        ${npmSet} init.author.name "${user.npm.initAuthorName}"
        ${npmSet} init.author.email "${user.npm.initAuthorEmail}"
        ${npmSet} init.author.url "${user.npm.initAuthorUrl}"
        ${npmSet} init.license "${user.npm.initLicense}"
        ${npmSet} init.version "${user.npm.initVersion}"
      '';
}
