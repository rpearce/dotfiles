{ pkgs, ... }:

rec {
  imports = [
    ../_common/aliases.nix
    ../_common/darwin/defaults.nix
    ../_common/darwin/nix-apps.nix
    ../_common/darwin/tmux.nix
    ../_common/env-variables.nix
    ../_common/fonts.nix
    ../_common/zsh
    ./homebrew.nix
    ./networking.nix
  ];

  system.stateVersion = 4;

  nix.useSandbox = false;
  nix.gc.automatic = false;
  nix.gc.interval = { Weekday = 5; Hour = 3; Minute = 15; }; # Thu 03:15
  nix.gc.options = "--delete-older-than 30d";
  nix.package = pkgs.nixUnstable;
  nix.extraOptions = "experimental-features = nix-command flakes";
  nix.trustedUsers = [ "root" "@admin" ];

  nix.trustedBinaryCaches = [
    #https://cache.ngi0.nixos.org
    https://cache.nixos.org
    https://nix-community.cachix.org
    https://rpearce.cachix.org
  ];

  nix.binaryCaches = nix.trustedBinaryCaches;

  nix.binaryCachePublicKeys = [
    #cache.ngi0.nixos.org-1:KqH5CBLNSyX184S9BKZJo1LxrxJ9ltnY2uAs5c/f1MA=
    cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=
    nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=
    rpearce.cachix.org-1:JfcsbYqjrn4Hb3nbBnlprokdSEE5xYdxZ39ikK7nOCM=
  ];

  services.nix-daemon.enable = true;

  users.nix.configureBuildUsers = true;

  environment.variables.NPM_TOKEN = "`cat $HOME/.npmrc 2>/dev/null | grep authToken | tr \"=\" \"\\n\" | tail -n 1`";

  environment.systemPackages = with pkgs; [
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
    nix-prefetch-git
    procs # https://github.com/dalance/procs
    rename
    ripgrep
    shellcheck
    speedtest-cli
    tokei # https://github.com/XAMPPRocky/tokei
    tmux-mem-cpu-load
    tree
    zsh-autosuggestions
    zsh-completions
  ];

  programs.bash.enable = true;

  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;
}
