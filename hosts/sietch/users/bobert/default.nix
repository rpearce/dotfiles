{ config
, pkgs
, ...
}:

let
  home_dir = "${config.home.homeDirectory}";
  common_dir = ../../../_common;
  xdg = import (common_dir + "/home/xdg") { inherit home_dir; };
in rec {
  inherit xdg;

  imports = [
    (common_dir + "/home/git")
    (common_dir + "/home/neovim")
  ];

  home.stateVersion = "21.05";

  home.file = {
    ".cabal/config".source = common_dir + "/conf/cabal.cabal";
    ".gemrc".source = common_dir + "/conf/.gemrc";
    ".inputrc".source = common_dir + "/conf/.inputrc";
    ".psqlrc".source = common_dir + "/conf/.psqlrc";
    ".ripgreprc".source = common_dir + "/conf/.ripgreprc";
    ".stack/config.yaml".source = common_dir + "/conf/stack.yaml";
    ".zshrc".source = common_dir + "/conf/.empty_zshrc";
    "${xdg.configHome}/alacritty/alacritty.yml".source = common_dir + "/conf/alacritty.yml";
    "${xdg.configHome}/bat/config".source = common_dir + "/conf/bat";
    "${xdg.configHome}/git/ignore".source = common_dir + "/conf/.gitignore";
  };

  programs.git.signing.key = "8EE70FB52D805C55";

  home.packages = with pkgs; [
    bashcards
    #dijo
    elixir
    exercism
    flyctl
    go
    #haskellPackages.pandoc
    #haskellPackages.patat
    heroku
    nodejs-18_x
    ruby_3_1
    tldr
    (yarn.override { nodejs = nodejs-18_x; })
    youtube-dl
  ];

  # NPM config options in lieu of no easy static config file
  home.activation.setNpmOptions =
    let
      npmSet = "$DRY_RUN_CMD ${pkgs.nodejs-16_x}/bin/npm config set";
    in
      config.lib.dag.entryAfter ["writeBoundary"] ''
        ${npmSet} init-author-name "Robert Pearce"
        ${npmSet} init-author-email "me@robertwpearce.com"
        ${npmSet} init-author-url "https://robertwpearce.com"
        ${npmSet} init-license "BSD-3"
        ${npmSet} init-version "0.1.0"
      '';

  home.activation.setSSH =
    config.lib.dag.entryAfter ["writeBoundary"] ''
      if [[ ! -f "$HOME/.ssh/id_ed25519" ]]; then
        echo "ssh: Setting up key..."
        ssh-keygen -t ed25519 -C "me@robertwpearce.com"

        echo "ssh: Starting ssh-agent in the background"
        eval "$(ssh-agent -s)"

        echo "ssh: writing config to store passphrases in keychain"
        cat <<EOF > "$HOME/.ssh/config"
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile "$HOME/.ssh/id_ed25519"
EOF

        echo "ssh: Adding private key to ssh-agent and storing passphrase in keychain"
        ssh-add -K "$HOME/.ssh/id_ed25519"
      fi
    '';

  home.activation.setVimDirs =
    config.lib.dag.entryAfter ["writeBoundary"] ''
      mkdir -p ${xdg.dataHome}/vim/backup/
      mkdir -p ${xdg.dataHome}/vim/swap/
      mkdir -p ${xdg.dataHome}/vim/undo/
    '';
}
