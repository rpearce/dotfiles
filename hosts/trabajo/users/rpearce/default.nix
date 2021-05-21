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
    ".gemrc".source = common_dir + "/conf/.gemrc";
    ".inputrc".source = common_dir + "/conf/.inputrc";
    ".psqlrc".source = common_dir + "/conf/.psqlrc";
    ".ripgreprc".source = common_dir + "/conf/.ripgreprc";
    "${xdg.configHome}/git/ignore".source = common_dir + "/conf/.gitignore";
    "${xdg.configHome}/bat/config".source = common_dir + "/conf/bat";
  };

  xdg = {
    enable = true;
    cacheHome = "${home_dir}/.cache";
    configHome = "${home_dir}/.config";
    dataHome = "${home_dir}/.data";
  };

  home.packages = with pkgs; [
    bashcards
    elixir
    git-lfs
    #haskellPackages.pandoc
    #haskellPackages.patat
    nodejs-14_x
    ruby
    (yarn.override { nodejs = nodejs-14_x; })
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

  home.activation.setSSH =
    config.lib.dag.entryAfter ["writeBoundary"] ''
      if [[ ! -f "$HOME/.ssh/id_ed25519" ]]; then
        echo "Setting up ssh key..."
        ssh-keygen -t ed25519 -C "me@robertwpearce.com"
        eval "$(ssh-agent -s)"
        ssh-add ~/.ssh/id_ed25519
      fi
    '';

  home.activation.setVimDirs =
    config.lib.dag.entryAfter ["writeBoundary"] ''
      mkdir -p ${xdg.dataHome}/vim/backup/
      mkdir -p ${xdg.dataHome}/vim/swap/
      mkdir -p ${xdg.dataHome}/vim/undo/
    '';
}
