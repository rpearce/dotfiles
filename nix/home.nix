{ config
, stdenv
, ...
}:

let
  sources = import ./sources.nix;
  rust = import ./rust.nix { inherit sources; };

  nixpkgsConfig = import ./config.nix // {
    packageOverrides = pkgz: rec {
      timetrack-cli = pkgz.haskell.packages.ghc882.callPackage
        "${sources.timetrack-cli.outPath}/default.nix"
        { };
    };
  };

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
    bash
    bash-completion
    bashcards
    bat
    cachix
    coreutils
    ctop
    dijo
    exa
    exercism
    findutils
    fswatch
    gnupg
    heroku
    jq
    lorri
    ncdu
    rename
    ripgrep
    ruby
    shellcheck
    speedtest-cli
    tldr
    #timetrack-cli
    tree
    zsh-completions

    # node
    nodejs-14_x
    (yarn.override { nodejs = nodejs-14_x; })

    # haskell
    haskellPackages.ghcid
    haskellPackages.hlint
    haskellPackages.hoogle
    haskellPackages.ormolu
    haskellPackages.pandoc
    haskellPackages.stylish-haskell
    stack

    # elm
    elmPackages.elm
    elmPackages.elm-format

    # elixir
    elixir

    # git
    gitAndTools.delta
    gitAndTools.diff-so-fancy
    gitAndTools.gh
    nix-prefetch-git

    # rust
    rust
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

  home.file.".cabal/config".source = ../conf/cabal.cabal;
  home.file.".gemrc".source = ../conf/.gemrc;
  home.file.".ghci".source = ../conf/.ghci;
  home.file.".inputrc".source = ../conf/.inputrc;
  home.file.".psqlrc".source = ../conf/.psqlrc;
  home.file.".ripgreprc".source = ../conf/.ripgreprc;
  home.file.".stack/config.yaml".source = ../conf/stack.yaml;
  home.file.".tmux.conf".source = ../conf/.tmux.conf;
  home.file."${xdg.configHome}/git/ignore".source = ../conf/.gitignore;

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

  home.activation.setSSH =
    config.lib.dag.entryAfter ["writeBoundary"] ''
      if [[ ! -f ~/.ssh/id_rsa.pub ]]; then
        echo "Setting up ssh key..."
        ssh-keygen -t rsa -C "${user.ssh.email}"
        eval "$(ssh-agent -s)"
        ssh-add ~/.ssh/id_rsa
      fi
    '';

  home.activation.setVimDirs =
    config.lib.dag.entryAfter ["writeBoundary"] ''
      mkdir -p ${xdg.dataHome}/vim/backup//
      mkdir -p ${xdg.dataHome}/vim/swap//
      mkdir -p ${xdg.dataHome}/vim/undo//
    '';
}
