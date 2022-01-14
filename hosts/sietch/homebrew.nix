{
  homebrew.enable = true;
  homebrew.autoUpdate = true;
  homebrew.brewPrefix = "/opt/homebrew/bin";
  homebrew.cleanup = "zap";
  homebrew.global.brewfile = true;
  homebrew.global.noLock = true;

  homebrew.taps = [
    "homebrew/cask"
    "homebrew/cask-versions"
    "hashicorp/tap"
    #"unisonweb/unison"
  ];

  homebrew.brews = [
    "clamav"
    "hashicorp/tap/nomad"
    "mas"
    #"postgres"
    #"spotify-tui"
    #"spotifyd"
    #"unison-language"
  ];

  homebrew.casks = [
    "alacritty"
    "brave-browser"
    "calibre"
    "deckset"
    "docker"
    "dropbox"
    #"element"
    "flux"
    "google-chrome"
    #"iterm2"
    #"libreoffice"
    "netnewswire"
    "oversight"
    #"pgadmin4"
    #"postico"
    #"psequel"
    "sketch"
    "slack"
    "spotify"
    #"tableplus"
    #"virtualbox"
    #"virtualbox-extension-pack"
    "vlc"
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