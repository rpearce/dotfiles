#!/usr/bin/env zsh

function has_cmd {
  hash "${1}" 2> /dev/null
}

# Source our zsh configs
if [[ -d "$ZDOTDIR" ]]; then
  source "${ZDOTDIR}/aliases.zsh"
  source "${ZDOTDIR}/history.zsh"
  source "${ZDOTDIR}/key-bindings.zsh"
  source "${ZDOTDIR}/prompt.zsh"
fi

# Add bin paths to PATH
[[ -d "/usr/local/sbin" ]] && export PATH="/usr/local/sbin:${PATH}"
[[ -d "${HOME}/.local/bin" ]] && export PATH="${HOME}/.local/bin:${PATH}"
[[ -d "${HOME}/go/bin" ]] && export PATH="${HOME}/go/bin:${PATH}"
[[ -d "${XDG_DATA_HOME}/cargo/bin" ]] && export PATH="${XDG_DATA_HOME}/cargo/bin:${PATH}"
[[ -d "${XDG_DATA_HOME}/yarn/bin" ]] && export PATH="${XDG_DATA_HOME}/yarn/bin:${PATH}"
[[ -d "${XDG_CONFIG_HOME}/utils" ]] && export PATH="${XDG_CONFIG_HOME}/utils:${PATH}"

# Homebrew
if [[ -d "/opt/homebrew" ]]; then
  # Include exports for PATH, for example.
  # https://docs.brew.sh/Manpage#shellenv
  eval "$(/opt/homebrew/bin/brew shellenv)"

  # Fix the correct sed not being used
  export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:${PATH}"

  # LLVM
  export PATH="/opt/homebrew/opt/llvm@13/bin:$PATH"
  export LDFLAGS="${LDFLAGS} -L/opt/homebrew/opt/llvm@13/lib"
  export CPPFLAGS="${CPPFLAGS} -I/opt/homebrew/opt/llvm@13/include"

  # PostgreSQL
  export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
  export LDFLAGS="${LDFLAGS} -L/opt/homebrew/opt/postgresql@16/lib"
  export CPPFLAGS="${CPPFLAGS} -I/opt/homebrew/opt/postgresql@16/include"

  # Ruby
  export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

  # Source zsh tools
  zsh_autosuggestions_path="/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  [[ -s "$zsh_autosuggestions_path" ]] && source "$zsh_autosuggestions_path"

  # Source zsh syntax highlighting
  zsh_syntax_highlighting_path="/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  [[ -s "$zsh_syntax_highlighting_path" ]] && source "$zsh_syntax_highlighting_path"

  # Source asdf tools
  asdf_script_path="/opt/homebrew/opt/asdf/libexec/asdf.sh"
  [[ -s "$asdf_script_path" ]] && source "$asdf_script_path"
fi

# https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key
export GPG_TTY=$(tty)

# Set default editor to nvim if we have it
if has_cmd nvim; then
  export EDITOR="nvim"
fi

# Set default manpager to bat if we have it
if has_cmd bat; then
  export MANPAGER="sh -c 'col -b | bat -l man -p'"
fi

# FZF and Ripgrep VIM integration
if has_cmd fzf && has_cmd rg; then
  export FZF_DEFAULT_COMMAND='rg --files --follow --hidden --no-ignore'
fi

# Load NVM
if [[ -d "${XDG_CONFIG_HOME}/nvm" ]]; then
  export NVM_DIR="${XDG_CONFIG_HOME}/nvm"
  [ -s "${NVM_DIR}/nvm.sh" ] && source "${NVM_DIR}/nvm.sh"
  [ -s "${NVM_DIR}/bash_completion" ] && source "${NVM_DIR}/bash_completion"
fi

# Set an NPM_TOKEN
if [[ -s "${HOME}/.npmrc" ]]; then
 export NPM_TOKEN=$(cat "${HOME}/.npmrc" | grep //registry.npmjs.org/:_authToken | cut -d "=" -f 2)
fi

# Set a FONT_AWESOME_NPM_AUTH_TOKEN
if [[ -s "${HOME}/.farc" ]]; then
 export FONT_AWESOME_NPM_AUTH_TOKEN=$(cat "${HOME}/.farc")
fi

# Run the nix-daemon script
nix_daemon_script_path="/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
[[ -s "${nix_daemon_script_path}" ]] && source "${nix_daemon_script_path}"

# ghcup
ghcup_script_path="${XDG_DATA_HOME}/ghcup/env"
[[ -s "${ghcup_script_path}" ]] && source "${ghcup_script_path}"

# 1Password
# if has_cmd op; then
#   export NPM_TOKEN=op://Private/NPM/credential
#   export FONT_AWESOME_NPM_AUTH_TOKEN=op://Private/FontAwesome/credential
# fi
