{
  homebrew.enable = true;
  homebrew.brewPrefix = "/opt/homebrew/bin";
  homebrew.global.brewfile = true;
  homebrew.onActivation.autoUpdate = true;
  homebrew.onActivation.cleanup = "zap";
  homebrew.onActivation.upgrade = true;

  homebrew.taps = [
    "homebrew/cask"
    "homebrew/cask-versions"
    "hashicorp/tap"
    #"unisonweb/unison"
  ];

  homebrew.brews = [
    "clamav"
    #"hashicorp/tap/nomad"
    "mas"
    "postgresql@14"
    #"spotify-tui"
    #"spotifyd"
    #"unison-language"
  ];

  homebrew.casks = [
    "alacritty"
    "brave-browser"
    #"calibre"
    "colour-contrast-analyser"
    "deckset"
    "discord"
    "docker"
    "dropbox"
    #"flux"
    "google-chrome"
    #"iterm2"
    #"libreoffice"
    "netnewswire"
    "oversight"
    #"pgadmin4"
    #"postico"
    "postman"
    "proxyman"
    #"psequel"
    "sketch"
    "slack"
    "spotify"
    #"tableplus"
    #"virtualbox"
    #"virtualbox-extension-pack"
    "vlc"
    "visual-studio-code"
    "zoom"
  ];

  homebrew.masApps = {
    "1Password" = 1333542190;
    Hush = 1544743900;
    "Just Focus" = 1142151959;
    Keynote = 409183694;
    Kindle = 405399194;
    #Medis = 1063631769;
    Xcode = 497799835;
  };

  homebrew.extraConfig = ''
    cask "firefox-developer-edition", args: { language: "es" }
    cask_args appdir: "~/Applications", require_sha: true
  '';
}
