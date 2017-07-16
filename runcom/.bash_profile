DOTFILES_DIR="$HOME/.dotfiles"

# Source dotfiles

for DOTFILE in "$DOTFILES_DIR"/system/.{function,function_*,path,env,alias,prompt,nvm}; do
  [ -f "$DOTFILE" ] && . "$DOTFILE"
done

# Clean up

unset DOTFILE

export DOTFILES_DIR

# iTerm2 stuff

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# Start rbenv

eval "$(rbenv init -)"

# Use git command instead of hub.
# E.g., `$ git create` is really
# `$ hub create`.

eval "$(hub alias -s)"

export PATH="$HOME/.yarn/bin:$PATH"
