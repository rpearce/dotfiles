XDG_CONFIG_HOME="$HOME/.config"
XDG_DATA_HOME="$HOME/Dropbox/.data"
XDG_CACHE_HOME="$HOME/.cache"

# Source dotfiles

for DOTFILE in $XDG_CONFIG_HOME/dotfiles/system/.{path,env,pkgs,prompt,git,alias,fn*,npm,ripgrep}; do
  . "$DOTFILE"
done

# Export XDG

export XDG_CONFIG_HOME
export XDG_DATA_HOME
export XDG_CACHE_HOME

# Clean up

unset DOTFILE

# iTerm2

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
