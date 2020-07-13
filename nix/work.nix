{ config
, ...
}:

let
  sources = import ./sources.nix;

  nixpkgsConfig = import ./config.nix;
  pkgs = import sources.nixpkgs { config = { inherit nixpkgsConfig; }; };

  user = import ./user.nix;

in rec {
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  home.stateVersion = "20.09";

  xdg = {
    enable = true;
    configHome = "${builtins.getEnv "HOME"}/.config";
    dataHome = "${builtins.getEnv "HOME"}/.data";
    cacheHome = "${builtins.getEnv "HOME"}/.cache";
  };

  nixpkgs = {
    config = {
      _module.args = {
        pkgs = pkgs;
      };
    };
  };

  home.packages = with pkgs; [
    # CLI
    awscli
    bash
    bash-completion
    bashcards
    bat
    coreutils
    ctop
    findutils
    fswatch
    gnupg
    jq
    ncdu
    niv
    openvpn
    rename
    ripgrep
    ruby_2_6
    shellcheck
    speedtest-cli
    tldr
    tree
    watchman
    zsh-completions

    # node
    nodejs-14_x
    (yarn.override { nodejs = nodejs-14_x; })

    # elixir
    elixir

    # git
    git-lfs
    gitAndTools.diff-so-fancy
    nix-prefetch-git
  ];

  programs.home-manager = (import ./programs/home-manager.nix { });
  programs.zsh = (import ./programs/zsh/default.nix {
    xdg = xdg;
    hostname = user.hostname;
  });
  programs.git = (import ./programs/git.nix {
    gitConfig = user.git;
    pkgs = pkgs;
  });
  programs.neovim = (import ./programs/neovim/default.nix {
    pkgs = pkgs;
    sources = sources;
  });
  #programs.vim = (import ./programs/vim/default.nix {
  #  pkgs = pkgs;
  #  sources = sources;
  #});

  home.file.".gemrc".source = ../conf/.gemrc;
  home.file.".inputrc".source = ../conf/.inputrc;
  home.file.".psqlrc".source = ../conf/.psqlrc;
  home.file.".ripgreprc".source = ../conf/.ripgreprc;
  home.file."${xdg.configHome}/git/ignore".source = ../conf/.gitignore;

  home.activation.setVimDirs =
    config.lib.dag.entryAfter ["writeBoundary"] ''
      mkdir -p ${xdg.dataHome}/vim/backup//
      mkdir -p ${xdg.dataHome}/vim/swap//
      mkdir -p ${xdg.dataHome}/vim/undo//
    '';

  # NPM config options in lieu of no easy static config file
  home.activation.setNpmOptions =
    let
      npmSet = "$DRY_RUN_CMD ${pkgs.nodejs-14_x}/bin/npm set";
    in
      config.lib.dag.entryAfter ["writeBoundary"] ''
        ${npmSet} init.author.name "${user.npm.initAuthorName}"
        ${npmSet} init.author.email "${user.npm.initAuthorEmail}"
        ${npmSet} init.author.url "${user.npm.initAuthorUrl}"
        ${npmSet} init.license "${user.npm.initLicense}"
        ${npmSet} init.version "${user.npm.initVersion}"
      '';
}
