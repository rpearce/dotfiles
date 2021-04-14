{ config
, stdenv
, ...
}:

let
  sources = import ./sources.nix;
  rust = import ./rust.nix { inherit sources; };

  nixpkgsConfig = import ./config.nix // {
    packageOverrides = pkgz: rec {
      #timetrack-cli = pkgz.haskell.packages.ghc882.callPackage
      #  "${sources.timetrack-cli.outPath}/default.nix"
      #  { };
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
    bandwhich
    bash
    bash-completion
    bashcards
    bat
    cachix
    coreutils
    ctop
    #dijo
    diskonaut
    exa
    exercism
    findutils
    fswatch
    gnupg
    heroku
    jq
    #lorri
    ncdu
    procs # https://github.com/dalance/procs
    rename
    ripgrep
    shellcheck
    #silicon # https://github.com/Aloxaf/silicon
    speedtest-cli
    #spotify-tui
    #spotifyd
    tldr
    #timetrack-cli
    tokei # https://github.com/XAMPPRocky/tokei
    tree
    youtube-dl
    zsh-completions

    elixir
    ruby
    rust
    nodejs-15_x
    (yarn.override { nodejs = nodejs-15_x; })

    # elm
    #elmPackages.elm
    #elmPackages.elm-format

    # haskell
    #haskellPackages.ghcid
    #haskellPackages.hlint
    #haskellPackages.hoogle
    #haskellPackages.ormolu
    #haskellPackages.pandoc
    #haskellPackages.stylish-haskell
    #stack

    # git
    gitAndTools.delta
    gitAndTools.diff-so-fancy
    gitAndTools.gh
    #nix-prefetch-git
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
  home.file."${xdg.configHome}/nix/nix.conf".source = ../conf/nix.conf;

  # NPM config options in lieu of no easy static config file
  home.activation.setNpmOptions =
    let
      npmSet = "$DRY_RUN_CMD ${pkgs.nodejs-15_x}/bin/npm set";
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
