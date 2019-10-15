####################################################
# PATH
####################################################

CABAL="$HOME/.cabal/bin"
DOT_LOCAL="$HOME/.local/bin"
LOCAL="/usr/local/bin"
PYTHON="/usr/local/opt/python/libexec/bin"
SBIN="/usr/local/sbin"
YARN="$HOME/.yarn/bin"
YARN_NM="$XDG_CONFIG_HOME/yarn/global/node_modules/.bin"

export PATH="$LOCAL:$DOT_LOCAL:$CABAL:$YARN:$YARN_NM:$PYTHON:$SBIN:$PATH"