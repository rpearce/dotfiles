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
    "awscli"
    "mas"
    "openvpn"
    "postgres"
  ];

  homebrew.casks = [
    #"deckset"
    "alacritty"
    "docker"
    "firefox-developer-edition"
    "flux"
    #"font-hack-nerd-font"
    #"font-lilex"
    "google-chrome"
    "iterm2"
    #"oversight"
    #"pgadmin4"
    "postico"
    #"psequel"
    "postman"
    "slack"
    "spotify"
    #"tableplus"
    #"virtualbox"
    #"virtualbox-extension-pack"
    #"visual-studio-code"
    "zoom"
  ];

  homebrew.masApps = {
    "1Password" = 1333542190;
    Hush = 1544743900;
    "Just Focus" = 1142151959;
    Keynote = 409183694;
    Kindle = 405399194;
    Medis = 1063631769;
    Xcode = 497799835;
  };

  homebrew.extraConfig = ''
    cask_args appdir: "~/Applications"
  '';
}
