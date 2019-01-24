XDG_CONFIG_HOME="$HOME/.config"
XDG_DATA_HOME="$HOME/Dropbox/.data"

# Source dotfiles

for DOTFILE in $XDG_CONFIG_HOME/system/.{function,function_*,path,env,alias,prompt,nvm,nix}; do
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

# Use git command instead of hub.
# E.g., `$ git create` is really
# `$ hub create`.

eval "$(hub alias -s)"
