{ config
, pkgs
, ...
}:

let
  home_dir = "${config.home.homeDirectory}";
  common_dir = ../../../_common;
in rec {
  imports = [
    (common_dir + "/home/git")
    (common_dir + "/home/neovim")
  ];

  home.stateVersion = "21.05";

  home.file = {
    ".cabal/config".source = common_dir + "/conf/cabal.cabal";
    ".gemrc".source = common_dir + "/conf/.gemrc";
    ".ghci".source = common_dir + "/conf/.ghci";
    ".inputrc".source = common_dir + "/conf/.inputrc";
    ".psqlrc".source = common_dir + "/conf/.psqlrc";
    ".ripgreprc".source = common_dir + "/conf/.ripgreprc";
    ".stack/config.yaml".source = common_dir + "/conf/stack.yaml";
    ".tmux.conf".source = common_dir + "/conf/.tmux.conf";
    "${xdg.configHome}/git/ignore".source = common_dir + "/conf/.gitignore";
    "${xdg.configHome}/bat/config".source = common_dir + "/conf/bat";
  };

  xdg = {
    enable = true;
    cacheHome = "${home_dir}/.cache";
    configHome = "${home_dir}/.config";
    dataHome = "${home_dir}/.data";
  };

  #programs.ssh.enable = true;

  home.packages = with pkgs; [
    bashcards
    #dijo
    elixir
    exercism
    heroku
    nodejs-14_x
    ruby
    (yarn.override { nodejs = nodejs-14_x; })
    youtube-dl

    # haskell
    #haskellPackages.pandoc
    #haskellPackages.patat
    #stack
  ];

  # NPM config options in lieu of no easy static config file
  home.activation.setNpmOptions =
    let
      npmSet = "$DRY_RUN_CMD ${pkgs.nodejs-16_x}/bin/npm set";
    in
      config.lib.dag.entryAfter ["writeBoundary"] ''
        ${npmSet} init.author.name "Robert Pearce"
        ${npmSet} init.author.email "me@robertwpearce.com"
        ${npmSet} init.author.url "https://robertwpearce.com"
        ${npmSet} init.license "BSD-3"
        ${npmSet} init.version "0.1.0"
      '';

  #home.activation.setSSH =
  #  config.lib.dag.entryAfter ["writeBoundary"] ''
  #    if [[ ! -f "$HOME/.ssh/id_rsa.pub" ]]; then
  #      echo "Setting up ssh key..."
  #      ssh-keygen -t rsa -C "${user.ssh.email}"
  #      eval "$(ssh-agent -s)"
  #      ssh-add ~/.ssh/id_rsa
  #    fi
  #  '';

  home.activation.setVimDirs =
    config.lib.dag.entryAfter ["writeBoundary"] ''
      mkdir -p ${xdg.dataHome}/vim/backup/
      mkdir -p ${xdg.dataHome}/vim/swap/
      mkdir -p ${xdg.dataHome}/vim/undo/
    '';
}
