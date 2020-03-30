{ config
, ...
}:

let
  pkgs = import ./pkgs.nix;
  user = import ./user.nix;
  xdg = import ./xdg.nix;
  all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};

in {
  nixpkgs = {
    config = {
      _module.args = {
        pkgs = pkgs;
      };

      allowBroken = true;
      allowUnfree = true;

      #packageOverrides = pkgs: rec {
      #  timetrack-cli = pkgs.haskellPackages.callPackage ./nixpkgs/timetrack-cli/default.nix { };
      #};
    };
  };

  xdg = xdg;

  home.packages = with pkgs; [
    # CLI
    #asciinema
    bash
    bash-completion
    bat
    cachix
    coreutils
    ctop
    exercism
    findutils
    #ffmpeg
    fswatch
    gnupg
    heroku
    jq
    ncdu
    rename
    ripgrep
    ruby_2_6
    speedtest-cli
    tldr
    #timetrack-cli
    tree
    zsh-completions

    # node
    nodejs-13_x
    (yarn.override { nodejs = nodejs-13_x; })
    nodePackages.node2nix

    # haskell
    cabal2nix
    haskellPackages.ghcid
    haskellPackages.hakyll
    haskellPackages.hlint
    haskellPackages.hoogle
    haskellPackages.pandoc
    haskellPackages.stylish-haskell
    stack
    (all-hies.selection { selector = p: { inherit (p) ghc882; }; })

    # elm
    elmPackages.elm
    elmPackages.elm-format

    # elixir
    elixir

    # git
    gitAndTools.diff-so-fancy
    nix-prefetch-git
  ];

  programs.home-manager = (import ./programs/home-manager.nix { });
  programs.zsh = (import ./programs/zsh/default.nix { xdg = xdg; hostname = user.hostname; });
  programs.git = (import ./programs/git.nix { gitConfig = user.git; pkgs = pkgs; });
  #programs.neovim = (import ./programs/neovim/default.nix { pkgs = pkgs; });
  programs.vim = (import ./programs/vim/default.nix { pkgs = pkgs; });

  home.file.".cabal/config".source = ../conf/cabal.cabal;
  home.file.".gemrc".source = ../conf/.gemrc;
  home.file.".ghci".source = ../conf/.ghci;
  home.file.".gitignore".source = ../conf/.gitignore;
  home.file.".inputrc".source = ../conf/.inputrc;
  home.file.".psqlrc".source = ../conf/.psqlrc;
  home.file.".ripgreprc".source = ../conf/.ripgreprc;
  home.file.".stack/config.yaml".source = ../conf/stack.yaml;
  home.file.".tmux.conf".source = ../conf/.tmux.conf;

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
