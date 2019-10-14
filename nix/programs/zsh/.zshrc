####################################################
# prompt
####################################################

function __git_branch_status {
  if $(__git_repo_initialized); then
    if [[ -z $(git status -s) ]]; then
      echo -e "%F{green}✔"
    else
      echo -e "%F{red}✗"
    fi
  fi
}

function __git_repo_initialized {
  git ls-files >& /dev/null
}

autoload -Uz vcs_info
autoload -U colors && colors
autoload -Uz compinit && compinit

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' actionformats "%b|%a %m%u%c"
zstyle ':vcs_info:git*' formats "%F{242}%b%f %m%u%c"

precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )

typeset prompt_newline=$'\n%{\r%}'
typeset prompt_path=$'%F{blue}%B%~%b%f '
typeset prompt_symbol=$'%F{214}%Bλ%b%f '
typeset prompt_vcs_info=$'$vcs_info_msg_0_'
typeset prompt_branch_status=$'$(__git_branch_status)'

local -ah ps1

ps1=(
  $prompt_path
  $prompt_vcs_info
  $prompt_branch_status
  $prompt_newline
  $prompt_symbol
)

setopt prompt_subst
PROMPT="${(j..)ps1}"

####################################################
# nix
####################################################

[[ -f ~/.nix-profile/etc/profile.d/nix.sh ]] && . ~/.nix-profile/etc/profile.d/nix.sh

export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH

####################################################
# completion
####################################################

[[ -f ~/.nix-profile/etc/profile.d/bash_completion.sh ]] && . ~/.nix-profile/etc/profile.d/bash_completion.sh
[[ -f ~/.nix-profile/etc/bash_completion.d/git-completion.bash ]] && . ~/.nix-profile/etc/bash_completion.d/git-completion.bash
[[ -f ~/.nix-profile/etc/bash_completion.d/git-prompt.sh ]] && . ~/.nix-profile/etc/bash_completion.d/git-prompt.sh

####################################################
# homebrew
####################################################

if test ! $(command -v brew); then
  [[ -f $(brew --prefix)/etc/bash_completion.d/brew ]] && . $(brew --prefix)/etc/bash_completion.d/brew
  [[ -f $(brew --prefix)/etc/bash_completion.d/brew-services ]] && . $(brew --prefix)/etc/bash_completion.d/brew-services
fi

####################################################
# bat
####################################################

export MANPAGER="sh -c 'col -b | bat -l man -p'"

####################################################
# misc functions
####################################################

weather() {
  local CITY=${1}
  curl "wttr.in/$CITY"
}

timestamp() {
  date +%Y-%m-%dT%H:%M:%SZ
}

date_ymd() {
  date +%Y-%m-%d
}

# Instagram movie function

square_movie() {
  ffmpeg -i $1 -an -vf "pad=max(iw\,ih):ow:(ow-iw)/2:(oh-ih)/2:color=white" $2
}

# Create a new directory and enter it

mk() {
  mkdir -p "$@" && cd $_
}

# Fuzzy find file/dir

ff()  { find . -type f -iname "$1";   }
fff() { find . -type f -iname "*$1*"; }
fd()  { find . -type d -iname "$1";   }
fdf() { find . -type d -iname "*$1*"; }

# Open git project in browser

gh() {
  open $(git config remote.origin.url | sed "s/git@\(.*\):\(.*\).git/https:\/\/\1\/\2/")/$1$2
}

# Get gzipped file size

gz() {
  local ORIGSIZE=$(wc -c < "$1")
  local GZIPSIZE=$(gzip -c "$1" | wc -c)
  local RATIO=$(echo "$GZIPSIZE * 100/ $ORIGSIZE" | bc -l)
  local SAVED=$(echo "($ORIGSIZE - $GZIPSIZE) * 100/ $ORIGSIZE" | bc -l)
  printf "orig: %d bytes\ngzip: %d bytes\nsave: %2.0f%% (%2.0f%%)\n" "$ORIGSIZE" "$GZIPSIZE" "$SAVED" "$RATIO"
}

# macOS: Reset not being able to find camera

fix-camera() {
  sudo killall AppleCameraAssistant
  sudo killall VDCAssistant
}

# Get IP from hostname

hostname2ip() {
  ping -c 1 "$1" | egrep -m1 -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'
}

####################################################
# iTerm2
####################################################

test -e "${HOME}/.iterm2_shell_integration.bash" && . "${HOME}/.iterm2_shell_integration.bash"
