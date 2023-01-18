#!/usr/bin/env zsh

# Create home for zsh history if it doesn't exist
[ -d "${XDG_STATE_HOME}/zsh" ] || mkdir -p "${XDG_STATE_HOME}/zsh"

HISTFILE="${XDG_STATE_HOME}/zsh/history"
HISTSIZE=500000
SAVEHIST=500000

# https://zsh.sourceforge.io/Doc/Release/Options.html
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FCNTL_LOCK
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
