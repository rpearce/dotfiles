#!/usr/bin/env bash

# Set XDG directories
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_LIB_HOME="${XDG_LIB_HOME:-$HOME/.local/lib}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# Misc
export EDITOR="vim"
export LANG="en_US.UTF-8"
export TERM="screen-256color"

# Set XDG for tools
export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdf/asdfrc"
export ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"
export CABAL_CONFIG="${XDG_CONFIG_HOME}/cabal/config"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export CURL_HOME="${XDG_CONFIG_HOME}/curl"
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
export GHCUP_USE_XDG_DIRS="true"
export PSQLRC="${XDG_CONFIG_HOME}/pg/psqlrc"
export PSQL_HISTORY="${XDG_STATE_HOME}/psql_history"
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/ripgrep/config"
export RUSTUP_HOME="${XDG_DATA_HOME}"/rustup
export TMUX_PLUGIN_MANAGER_PATH="${XDG_DATA_HOME}/tmux/plugins"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export ZLIB="${ZDOTDIR}/lib"

# Disable telemetry for common tools
export ASTRO_TELEMETRY_DISABLED=1
export GATSBY_TELEMETRY_DISABLED=1
export NEXT_TELEMETRY_DISABLED=1
export STORYBOOK_DISABLE_TELEMETRY=1
export TELEMETRY_DISABLED=1
. "/Users/bobert/.local/share/cargo/env"
