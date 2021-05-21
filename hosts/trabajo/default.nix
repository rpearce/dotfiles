{ pkgs, ... }:

rec {
  imports = [
    ../_common/darwin/defaults.nix
    ../_common/darwin/nix-apps.nix
    ../_common/darwin/tmux.nix
    ../_common/darwin/zsh.nix
    ./aliases.nix
    ./fonts.nix
    ./homebrew.nix
    ./networking.nix
  ];

  system.stateVersion = 4;

  nix.useSandbox = true;
  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 30d";
  nix.package = pkgs.nixUnstable;
  nix.extraOptions = "experimental-features = nix-command flakes ca-references";
  nix.trustedUsers = [ "root" "@admin" ];

  nix.trustedBinaryCaches = [
    https://cache.nixos.org
    https://rpearce.cachix.org
  ];

  nix.binaryCaches = nix.trustedBinaryCaches;

  nix.binaryCachePublicKeys = [
    cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=
    rpearce.cachix.org-1:JfcsbYqjrn4Hb3nbBnlprokdSEE5xYdxZ39ikK7nOCM=
  ];

  services.nix-daemon.enable = true;

  users.nix.configureBuildUsers = true;

  environment.variables = {
    EDITOR = "nvim";
    MANPAGER = "sh -c 'col -b | bat -l man -p'";
    #NPM_TOKEN = "`cat ~/.npmrc 2>/dev/null | grep authToken | tr \"=\" \"\\n\" | tail -n 1`";
    PATH = builtins.concatStringsSep ":" [
      "/usr/local/sbin"
      "$HOME/.local/bin"
      "$HOME/.yarn/bin"
      "$PATH"
    ];
    RIPGREP_CONFIG_PATH = "$HOME/.ripgreprc";
    SHELL = "${pkgs.zsh}/bin/zsh";
    TERM = "xterm-256color";
  };

  environment.systemPackages = with pkgs; [
    awscli
    #bandwhich
    bash
    bash-completion
    bat
    cachix
    coreutils
    ctop
    diskonaut
    exa
    findutils
    fzf
    gitAndTools.delta
    gitAndTools.diff-so-fancy
    gitAndTools.gh
    gnupg
    htop
    jq
    ncdu
    procs # https://github.com/dalance/procs
    rename
    ripgrep
    shellcheck
    speedtest-cli
    tokei # https://github.com/XAMPPRocky/tokei
    tree
    zsh-autosuggestions
    zsh-completions
  ];

  programs.bash.enable = true;

  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;
}
