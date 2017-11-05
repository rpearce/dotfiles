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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.yarn/bin:$PATH"
