#!/usr/bin/env zsh

# TODO: refactor

function __git_branch_status() {
  if $(__git_repo_initialized); then
    if [[ -z $(git status -s) ]]; then
      echo -e "%B%F{green}✔%f%b"
    else
      echo -e "%B%F{red}✗%f%b"
    fi
  fi
}

function __git_repo_initialized() {
  git ls-files >& /dev/null
}

function __git_can_parse_rev() {
  (git rev-parse @ && git rev-parse @'{u}') >& /dev/null
}

function __git_arrows() {
  if $(__git_repo_initialized && __git_can_parse_rev); then
    local arrows left right
    local -a counts

    counts=($(command git rev-list --left-right --count HEAD...@'{u}'))
    left=counts[1]
    right=counts[2]

    (( right > 0 )) && arrows+="⇣"
    (( left > 0 )) && arrows+="⇡"

    echo -e $arrows
  fi
}

autoload -Uz vcs_info
autoload -U colors && colors
autoload -Uz compinit && compinit

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*'             actionformats       "%F{242}%b%f%F{cyan}|%f%a %m%u%c"
zstyle ':vcs_info:git*'             formats             "%F{242}%b%f %m%u%c"

# Setup completion cache
zstyle ':completion::complete:*'    use-cache           yes                                 # Enable cache for completions
zstyle ':completion::complete:*'    cache-path          "${XDG_CACHE_HOME}/zsh/.zcompcache" # Configure completion cache path

# Configure matches and grouping in completion menu
zstyle ':completion:*'              matcher-list        'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*' # Enable case insensitive completion
zstyle ':completion:*:*:*:*:*'      menu                select                                      # Enable highlighting in menu
zstyle ':completion:*:options'      auto-description    '%d'
zstyle ':completion:*:options'      description         yes
zstyle ':completion:*:matches'      group               yes                                         # Separate matches in menu into groups
zstyle ':completion:*'              group-name          ''                                          # Separate matches in menu into groups

# Format group matches in completion menu
# zstyle ':completion:*:descriptions' format              '[%d]'                             # see https://github.com/Aloxaf/fzf-tab/issues/43.
zstyle ':completion:*:corrections'  format              '%F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:messages'     format              '%F{purple}-- %d --%f'
zstyle ':completion:*:warnings'     format              '%F{red}-- no matches found --%f'

compinit -d "${XDG_CACHE_HOME}/zsh/.zcompdump-${ZSH_VERSION}"

function precmd_vcs_info {
  vcs_info
}
precmd_functions+=( precmd_vcs_info )

typeset prompt_newline=$'\n%{\r%}'
typeset prompt_path=$'%F{blue}%B%~%b%f '
typeset prompt_symbol=$'%F{214}%Bλ%b%f '
typeset prompt_vcs_info=$'$vcs_info_msg_0_'
typeset prompt_branch_status=$'$(__git_branch_status) '
typeset prompt_arrows=$'%B%F{cyan}$(__git_arrows)%f%b'

local -ah ps1

ps1=(
  $prompt_path
  $prompt_vcs_info
  $prompt_branch_status
  $prompt_arrows
  $prompt_newline
  $prompt_symbol
)

setopt extendedglob
setopt prompt_subst

PROMPT="${(j..)ps1}"
