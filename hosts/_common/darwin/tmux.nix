{
  programs.tmux.enable = true;
  programs.tmux.enableSensible = true;
  programs.tmux.enableMouse = true;
  programs.tmux.enableFzf = true;
  programs.tmux.enableVim = true;
  programs.tmux.extraConfig = ''
    ############################################################################
    # Misc                                                                     #
    ############################################################################

    # Colors
    set -ga terminal-overrides ',*256col*:Tc'

    # Rebind prefix key from C-b to C-Space
    set -g prefix C-Space
    unbind-key C-b
    bind-key C-Space send-prefix

    # Hot-reload tmux when configuration changes
    bind r source-file /etc/tmux.conf\; display "Reloaded."

    # Set history length
    set -g history-limit 10000

    # Enable clipboard interactivity
    set -g set-clipboard on

    # Set window notifications
    set -g monitor-activity on
    set -g visual-activity on

    # Update files on focus (using for neovim)
    set -g focus-events on

    # macOS Command+K (Clear scrollback buffer)
    bind -n C-k clear-history

    # Pane Border
    set -g pane-border-style fg='#bd93f9'
    set -g pane-active-border-style fg='#ff79c6'

    # Message text
    set -g message-style bg='#44475a',fg='#8be9fd'

    # Clock
    set-window-option -g clock-mode-colour '#50fa7b'

    ############################################################################
    # Status                                                                   #
    ############################################################################

    # Enable/Disable status [on | off]
    set -g status on

    # Update the status line every second
    set -g status-interval 1

    # Set the position of window lists [left | centre | right]
    set -g status-justify left

    # Set Vi style keybinding in the status line
    set -g status-keys vi

    # Set the status bar position [top, bottom]
    set -g status-position bottom

    # Set status bar background and foreground color.
    set -g status-style bg='#44475a',fg='#bd93f9'

    ############################################################################
    # Status Left                                                              #
    ############################################################################

    # Set max-length of status left area
    set -g status-left-length 30

    # When controlling tmux
    set -g status-left '#[bg=#f8f8f2]#[fg=#282a36]#{?client_prefix,#[bg=#ff79c6],} #S '

    # When controlling a pane
    set -ga status-left '#[bg=#44475a]#[fg=#ff79c6] #{?window_zoomed_flag, ↕  ,   }'

    ############################################################################
    # Window Status                                                            #
    ############################################################################

    set-window-option -g window-status-style fg='#bd93f9',bg=default
    set-window-option -g window-status-current-style fg='#ff79c6',bg='#282a36'
    set-window-option -g window-status-activity-style fg='#44475a',bg='#8be9fd'
    set -g window-status-current-format "#[fg=#44475a]#[bg=#bd93f9]#[fg=#f8f8f2]#[bg=#bd93f9] #I #W #[fg=#bd93f9]#[bg=#44475a]"
    set -g window-status-format "#[fg=#f8f8f2]#[bg=#44475a]#I #W #[fg=#44475a] "

    ############################################################################
    # Status Right                                                             #
    ############################################################################

    # Set max-length of status right area
    set -g status-right-length 150

    set -g status-right '#[fg=#8be9fd,bg=#44475a]#[fg=#44475a,bg=#8be9fd] #(tmux-mem-cpu-load --interval 2 --graph-lines 5) '
    set -ga status-right '#[fg=#ff79c6,bg=#8be9fd]#[fg=#44475a,bg=#ff79c6] #H '
    set -ga status-right '#[fg=#bd93f9,bg=#ff79c6]#[fg=#f8f8f2,bg=#bd93f9] %a %d %b %H:%M '





    # Active pane normal, other shaded out
    #setw -g window-style fg=colour240,bg=colour235
    #setw -g window-active-style fg=white,bg=black

    # Display the os version (Mac Os)
    #set -ag status-left " #[fg=black] #[fg=green,bright]  #(sw_vers -productVersion) #[default]"

    # Display the battery percentage (Mac OS)
    #set -ag status-left "#[fg=green,bg=default,bright] 🔋 #(pmset -g batt | tail -1 | awk '{print $3}' | tr -d ';') #[default]"

    # Display the cpu load (Mac OS)
    #set -g status-right "#[fg=green,bg=default,bright]  #(top -l 1 | grep -E "^CPU" | sed 's/.*://') #[default]"
  '';
}
