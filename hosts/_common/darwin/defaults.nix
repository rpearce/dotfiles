{
  # System - Enable font smoothing
  # Enables subpixel font rendering on non-Apple LCDs
  # Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
  system.defaults.NSGlobalDomain.AppleFontSmoothing = 1;

  # System - Enable dark mode
  system.defaults.NSGlobalDomain.AppleInterfaceStyle = "Dark";

  # Keyboard - Enable full keyboard access for all controls.
  # (e.g., enable Tab in modal dialogs)
  system.defaults.NSGlobalDomain.AppleKeyboardUIMode = 3;

  # Keyboard - Disable press-and-hold for keys in favor of key repeat
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;

  # Finder - Show filename extensions.
  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;

  # System - Automatically show scroll bars
  system.defaults.NSGlobalDomain.AppleShowScrollBars = "Automatic";

  # System - What temperature unit to use
  system.defaults.NSGlobalDomain.AppleTemperatureUnit = "Celsius";

  # Keyboard - Set a short Delay until key repeat.
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 15;

  # Keyboard - Set a fast keyboard repeat rate.
  system.defaults.NSGlobalDomain.KeyRepeat = 1;

  # System - Disable automatic capitalization as it’s annoying when typing code
  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;

  # System - Disable smart dashes as they’re annoying when typing code
  system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;

  # System - Disable automatic period substitution as it’s annoying when typing code
  system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;

  # System - Disable smart quotes as they’re annoying when typing code
  system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;

  # System - Disable auto-correct
  system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;

  # iCloud - Don't save new documents to iCloud by default
  system.defaults.NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;

  # System - Expand save panel by default.
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;

  # System - Decrease window resize duration
  system.defaults.NSGlobalDomain.NSWindowResizeTime = 0.001;

  # Printer - Expand print panel by default.
  system.defaults.NSGlobalDomain.PMPrintingExpandedStateForPrint = true;
  system.defaults.NSGlobalDomain.PMPrintingExpandedStateForPrint2 = true;

  # System - Auto hide menu bar
  system.defaults.NSGlobalDomain._HIHideMenuBar = false;

  # System - Disable 'Are you sure you want to open this application?' dialog
  system.defaults.LaunchServices.LSQuarantine = false;

  # System - Disable audio feedback when volume is changed
  system.defaults.NSGlobalDomain."com.apple.sound.beep.feedback" = 0;

  # Trackpad - Enable tap to click for current user and the login screen
  system.defaults.NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;

  # Trackpad - Disable natural scrolling
  system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = false;

  # Trackpad: Enable trackpad tap to click
  system.defaults.trackpad.Clicking = true;

  # Dock - Automatically hide and show
  system.defaults.dock.autohide = true;

  # Dock - Remove the auto-hiding delay
  system.defaults.dock.autohide-delay = 0.0;

  # Dock - Remove the animation when hiding/showing
  system.defaults.dock.autohide-time-modifier = 0.0;

  # Dock - Don’t show Dashboard as a Space
  system.defaults.dock.dashboard-in-overlay = true;

  # Dock - Don't group windows by application in Mission Control's Exposé
  system.defaults.dock.expose-group-by-app = false;

  # Dock - Don’t animate opening applications
  system.defaults.dock.launchanim = false;

  # Dock - Set the minimize/maximize window effect
  system.defaults.dock.mineffect = "scale";

  # Dock - Don’t automatically rearrange Spaces based on most recent use
  system.defaults.dock.mru-spaces = false;

  # Dock - Orient to the bottom
  system.defaults.dock.orientation = "bottom";

  # Dock - Show indicator lights for open applications
  system.defaults.dock.show-process-indicators = true;

  # Dock - Don’t show recent applications in Dock
  system.defaults.dock.show-recents = false;

  # Dock - Make icons of hidden applications translucent
  system.defaults.dock.showhidden = true;

  # Dock - Minimize apps to their icon
  system.defaults.dock.minimize-to-application = true;

  # Dock - Only show open applications in the dock
  system.defaults.dock.static-only = true;

  # Finder - Disable the warning when changing a file extension
  system.defaults.finder.FXEnableExtensionChangeWarning = false;

  # Finder - Display full POSIX path as window title.
  system.defaults.finder._FXShowPosixPathInTitle = true;

  # Finder - Add quit option
  system.defaults.finder.QuitMenuItem = true;

  # Screencapture - Save screenshots to the desktop
  system.defaults.screencapture.location = "$HOME/Desktop";

  # Keyboard - Enable keyboard mappings
  system.keyboard.enableKeyMapping = true;

  # Keyboard - Remap Caps Lock key to Control
  system.keyboard.remapCapsLockToControl = true;

  #defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
  #defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1
  #defaults -currentHost write -g com.apple.mouse.tapBehavior -int 1
  #defaults write -g com.apple.mouse.tapBehavior -int 1

  # The following settings are not configurable via nix-darwin
  system.activationScripts.postActivation.text = ''
    # Finder - Set $HOME as the default location for new windows
    defaults write com.apple.finder NewWindowTarget -string "PfDe"
    defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME"

    # Finder - Show the $HOME/Library folder
    chflags nohidden $HOME/Library

    # Finder - Show the /Volumes folder
    chflags nohidden /Volumes

    # Finder - Show hidden files
    defaults write com.apple.finder AppleShowAllFiles -bool true

    # Finder - Show path bar
    defaults write com.apple.finder ShowPathbar -bool true

    # Finder - Show status bar
    defaults write com.apple.finder ShowStatusBar -bool true

    # Finder - Use list view in all Finder windows
    defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

    # Finder - Disable the warning before emptying the Trash
    defaults write com.apple.finder WarnOnEmptyTrash -bool false

    # Finder - Allow text selection in Quick Look
    defaults write com.apple.finder QLEnableTextSelection -bool true

    # Dock - No bouncing icons
    defaults write com.apple.dock no-bouncing -bool true

    # Bluetooth - Increase sound quality for headphones/headsets
    defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

    # Dashboard - Disable Dashboard
    defaults write com.apple.dashboard mcx-disabled -bool true

    # Printer - Automatically quit printer app once the print jobs complete
    defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

    # Safari - Enable debug menu
    defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

    # Safari - Enable the Develop menu and the Web Inspector
    defaults write com.apple.Safari IncludeDevelopMenu -bool true
    defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

    # Safari - Add a context menu item for showing the Web Inspector in web views
    defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

    # Safari - Disable sending search queries to Apple
    defaults write com.apple.Safari UniversalSearchEnabled -bool false
    defaults write com.apple.Safari SuppressSearchSuggestions -bool true

    # Safari - Press Tab to highlight each item on a web page
    defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

    # Safari - Show the full URL in the address bar (note: this still hides the scheme)
    defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

    # Safari - Set home page to `about:blank` for faster loading
    defaults write com.apple.Safari HomePage -string "about:blank"

    # Safari - Prevent Safari from opening ‘safe’ files automatically after downloading
    defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

    # Safari - Allow hitting the Backspace key to go to the previous page in history
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

    # Safari - Hide the bookmarks bar by default
    defaults write com.apple.Safari ShowFavoritesBar -bool false

    # Safari - Hide Safari’s sidebar in Top Sites
    defaults write com.apple.Safari ShowSidebarInTopSites -bool false

    # Safari - Disable thumbnail cache for History and Top Sites
    defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

    # Safari - Make Safari’s search banners default to Contains instead of Starts With
    defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

    # Safari - Remove useless icons from Safari’s bookmarks bar
    defaults write com.apple.Safari ProxiesInBookmarksBar "()"

    # Safari - Enable continuous spellchecking
    defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true

    # Safari - Disable auto-correct
    defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

    # Safari - Warn about fraudulent websites
    defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

    # Safari - Disable Java
    defaults write com.apple.Safari WebKitJavaEnabled -bool false
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false

    # Safari - Block pop-up windows
    defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

    # Safari - Disable auto-playing video
    defaults write com.apple.Safari WebKitMediaPlaybackAllowsInline -bool false
    defaults write com.apple.SafariTechnologyPreview WebKitMediaPlaybackAllowsInline -bool false
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false
    defaults write com.apple.SafariTechnologyPreview com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false

    # Safari Enable “Do Not Track”
    defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

    # Safari - Update extensions automatically
    defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

    # Safari - Set DuckDuckGo as the search engine
    defaults write -g NSPreferredWebServices '{
      NSWebServicesProviderWebSearch = {
        NSDefaultDisplayName = DuckDuckGo;
        NSProviderIdentifier = "com.duckduckgo";
      };
    }'

    # Terminal - Only use UTF-8
    defaults write com.apple.terminal StringEncodings -array 4

    # Terminal - Disable audible and visual bells
    #defaults write com.apple.terminal "Bell" -bool false
    #defaults write com.apple.terminal "VisualBell" -bool false

    # Terminal - Enable Secure Keyboard Entry
    # See: https://security.stackexchange.com/a/47786/8918
    defaults write com.apple.terminal SecureKeyboardEntry -bool true

    # Terminal - Disable the annoying line marks
    defaults write com.apple.Terminal ShowLineMarks -int 0

    # iTerm2 - Don’t display the annoying prompt when quitting
    defaults write com.googlecode.iterm2 PromptOnQuit -bool false

    # Time Machine - Prevent from prompting to use new hard drives as backup volume
    #defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

    # Time Machine - Disable local Time Machine backups
    #hash tmutil &> /dev/null && sudo tmutil disable

    # Activity Monitor - Show the main window when launching
    defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

    # Activity Monitor - Visualize CPU usage in the Dock icon
    defaults write com.apple.ActivityMonitor IconType -int 5

    # Activity Monitor - Show all processes
    defaults write com.apple.ActivityMonitor ShowCategory -int 0

    # Activity Monitor - Sort results by CPU usage
    defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
    defaults write com.apple.ActivityMonitor SortDirection -int 0

    # Handoff - Turn off handing off between devices and this host
    defaults write com.apple.coreservices.useractivityd ActivityAdvertisingAllowed -bool no
    defaults write com.apple.coreservices.useractivityd ActivityReceivingAllowed -bool no

    # TextEdit - Use plain text mode for new documents
    defaults write com.apple.TextEdit RichText -int 0

    # TextEdit - Open and save files as UTF-8
    defaults write com.apple.TextEdit PlainTextEncoding -int 4
    defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

    # Disk Utility - Enable the debug menu
    defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
    defaults write com.apple.DiskUtility advanced-image-options -bool true

    # QuickTime Player - Auto-play videos when opened with QuickTime Player
    defaults write com.apple.QuickTimePlayerX MGPlayMovieOnOpen -bool true

    # AirDrop - Use AirDrop over every interface
    defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

    # Mac App Store - Enable the automatic update check
    defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

    # Mac App Store - Download newly available updates in background
    defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

    # Mac App Store - Check for software updates daily, not just once per week
    defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

    # Mac App Store - Install System data files & security updates
    defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

    # Mac App Store - Turn on app auto-update
    defaults write com.apple.commerce AutoUpdate -bool true

    # Mac App Store - Allow to reboot machine on macOS updates
    defaults write com.apple.commerce AutoUpdateRestartRequired -bool true

    # Messages - Disable sound effects
    defaults write com.apple.messageshelper.AlertsController PlaySoundsKey -bool false

    # Messages - Disable automatic emoji substitution (i.e. use plain text smileys)
    defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false

    # Messages - Disable smart quotes as it’s annoying for messages that contain code
    defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

    # Messages - Disable continuous spell checking
    defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

    # Photos - Prevent Photos from opening automatically when devices are plugged in
    defaults write com.apple.ImageCapture disableHotPlug -bool true

    # Game Center - Disable Game Center.
    defaults write com.apple.gamed Disabled -bool true
  '';
}
