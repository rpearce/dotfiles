{ pkgs, ... }:

{
  environment.variables = {
    EDITOR = "nvim";
    MANPAGER = "sh -c 'col -b | bat -l man -p'";
    PATH = builtins.concatStringsSep ":" [
      "/opt/homebrew/bin"
      "/opt/homebrew/sbin"
      "/usr/local/sbin"
      "$HOME/.cargo/bin"
      "$HOME/.local/bin"
      "$HOME/.yarn/bin"
      "$HOME/go/bin"
      "$PATH"
    ];
    RIPGREP_CONFIG_PATH = "$HOME/.ripgreprc";
    SHELL = "${pkgs.zsh}/bin/zsh";
    TERM = "screen-256color";
  };
}
