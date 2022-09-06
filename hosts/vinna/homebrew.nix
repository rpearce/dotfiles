{
  homebrew.enable = true;
  homebrew.autoUpdate = true;
  homebrew.cleanup = "zap";
  homebrew.global.brewfile = true;
  homebrew.global.noLock = true;

  homebrew.taps = [
    "homebrew/cask"
    #"homebrew/cask-fonts"
    "homebrew/cask-versions"
  ];

  homebrew.brews = [
    #"awscli"
    "mas"
    "openvpn"
    "postgres"
  ];

  homebrew.casks = [
    #"deckset"
    "alacritty"
    "colour-contrast-analyser"
    "docker"
    "firefox-developer-edition"
    #"flux"
    #"font-hack-nerd-font"
    #"font-lilex"
    "google-chrome"
    "iterm2"
    "openvpn-connect"
    #"oversight"
    #"pgadmin4"
    "postico"
    #"psequel"
    "postman"
    "proxyman"
    "slack"
    "spotify"
    #"tableplus"
    "tuple"
    #"virtualbox"
    #"virtualbox-extension-pack"
    "visual-studio-code"
    "zoom"
  ];

  homebrew.masApps = {
    "1Password" = 1333542190;
    "Balance Lock" = 1019371109;
    Hush = 1544743900;
    "Just Focus" = 1142151959;
    Keynote = 409183694;
    Kindle = 405399194;
    Medis = 1063631769;
    Xcode = 497799835;
  };

  homebrew.extraConfig = ''
    cask_args appdir: "~/Applications", require_sha: true
  '';
}
