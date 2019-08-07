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

if type brew 2&>/dev/null; then
  for completion_file in $(brew --prefix)/etc/bash_completion.d/*; do
    . "$completion_file"
  done
fi

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
