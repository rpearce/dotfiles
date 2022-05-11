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
    ".gemrc".source = common_dir + "/conf/.gemrc";
    ".inputrc".source = common_dir + "/conf/.inputrc";
    ".psqlrc".source = common_dir + "/conf/.psqlrc";
    ".ripgreprc".source = common_dir + "/conf/.ripgreprc";
    ".zshrc".source = ./conf/.zshrc;
    "${xdg.configHome}/alacritty/alacritty.yml".source = common_dir + "/conf/alacritty.yml";
    "${xdg.configHome}/bat/config".source = common_dir + "/conf/bat";
    "${xdg.configHome}/git/ignore".source = common_dir + "/conf/.gitignore";
  };

  programs.git.signing.key = "696FAC60B36CA0D3";

  home.packages = with pkgs; [
    bashcards
    elixir
    git-lfs
    nodejs-16_x
    ruby
    (yarn.override { nodejs = nodejs-16_x; })
  ];

  # NPM config options in lieu of no easy static config file
  home.activation.setNpmOptions =
    let
      npmSet = "$DRY_RUN_CMD ${pkgs.nodejs-16_x}/bin/npm set";
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
      if [[ ! -f "$HOME/.ssh/id_rsa" ]]; then
        echo "ssh: Setting up key..."
        ssh-keygen -t rsa -b 4096 -C "me@robertwpearce.com"

        echo "ssh: Starting ssh-agent in the background"
        eval "$(ssh-agent -s)"

        echo "ssh: writing config to store passphrases in keychain"
        cat <<EOF > "$HOME/.ssh/config"
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile "$HOME/.ssh/id_rsa"
EOF

        echo "ssh: Adding private key to ssh-agent and storing passphrase in keychain"
        ssh-add -K "$HOME/.ssh/id_rsa"
      fi
    '';

  home.activation.setVimDirs =
    config.lib.dag.entryAfter ["writeBoundary"] ''
      mkdir -p ${xdg.dataHome}/vim/backup/
      mkdir -p ${xdg.dataHome}/vim/swap/
      mkdir -p ${xdg.dataHome}/vim/undo/
    '';
}
