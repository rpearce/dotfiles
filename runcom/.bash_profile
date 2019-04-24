XDG_CONFIG_HOME="$HOME/.config"
XDG_DATA_HOME="$HOME/Dropbox/.data"

# Source dotfiles

for DOTFILE in $XDG_CONFIG_HOME/system/.{path,nix,env,alias,prompt,function,function_*,nvm}; do
  . "$DOTFILE"
done

# Clean up

unset DOTFILE

export XDG_CONFIG_HOME
export XDG_DATA_HOME

# iTerm2 stuff

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# Start rbenv

eval "$(rbenv init -)"
