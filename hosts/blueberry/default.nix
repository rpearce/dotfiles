{ pkgs, ... }:

rec {
  imports = [
    ../_common/darwin/defaults.nix
    ../_common/darwin/nix-apps.nix
    ../_common/darwin/tmux.nix
    ../_common/env-variables.nix
    ./aliases.nix
    ./fonts.nix
    ./homebrew.nix
    ./networking.nix
    ./zsh.nix
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
    https://dear-dia11y.cachix.org
    https://hakyll-nix-template.cachix.org
    https://nix-community.cachix.org
    https://ramda-guide.cachix.org
    https://robertwpearce-com.cachix.org
    https://rpearce.cachix.org
  ];

  nix.binaryCaches = nix.trustedBinaryCaches;

  nix.binaryCachePublicKeys = [
    cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=
    dear-dia11y.cachix.org-1:VJJN/ErCmfMrzRVHVIoHNFHPlHXwVYtKWGScFbK1JQc=
    hakyll-nix-template.cachix.org-1:CxnQmOKlNgl0CkF16YLWk7VGQ1xHWjEVkhuTtU+Op3w=
    nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=
    ramda-guide.cachix.org-1:crnO8ZnBhpJZ3OdCZYF2j1DLg1PeqLqTVEaWYRyxxDQ=
    robertwpearce-com.cachix.org-1:4UCteIm3LBgNsMuLSWMioqLWGHrYd4gKa7k6O9lIqUo=
    rpearce.cachix.org-1:JfcsbYqjrn4Hb3nbBnlprokdSEE5xYdxZ39ikK7nOCM=
  ];

  services.nix-daemon.enable = true;

  users.nix.configureBuildUsers = true;

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
    tree
    zsh-autosuggestions
    zsh-completions
  ];

  programs.bash.enable = true;

  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;
}
