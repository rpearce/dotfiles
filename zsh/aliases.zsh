#!/usr/bin/env zsh

function has_cmd {
  hash "${1}" 2> /dev/null
}

function is_mac {
  [[ "$OSTYPE" =~ "darwin" ]]
}

# Get YYYY-MM-DD date
alias date_ymd="date +%Y-%m-%d"

# Get YYYY-MM-DDTHH:MM:SSZ timestamp
alias timestamp="date +%Y-%m-%dT%H:%M:%SZ"

# List all file sizes
alias duf="du -sh *"

# Docker
if has_cmd docker; then
  alias dc="docker compose"
  alias dcr="docker compose run --rm"
  alias dcrp="dcr postgres psql postgresql://postgres@postgres:5432"
fi

# gpg
if has_cmd gpg; then
  alias gpgkill="gpgconf --kill gpg-agent"
fi

# Network
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias iplocal="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\\.){3}[0-9]*' | grep -Eo '([0-9]*\\.){3}[0-9]*' | grep -v '127.0.0.1'"

# Caffeinate — keep computer awake
alias kaffe='caffeinate -dusw $$'

# Long listing
alias ll="ls -lAFGh"

if has_cmd exa; then
  alias ll="exa -l --color always --icons -a -s type"
fi

# Get gzipped file size
function gz {
  local origsize, gzipsize, ratio, saved

  origsize=$(wc -c < "${1}")
  gzipsize=$(gzip -c "${1}" | wc -c)
  ratio=$(echo "${gzipsize} * 100/ ${origsize}" | bc -l)
  saved=$(echo "(${origsize} - ${gzipsize}) * 100 / ${origsize}" | bc -l)

  printf "orig: %d bytes\ngzip: %d bytes\nsave: %2.0f%% (%2.0f%%)\n" "${origsize}" "${gzipsize}" "${saved}" "${ratio}"
}

if is_mac; then
  # Open manpage as PDF on macOS
  function manpdf {
    man -t "${1}" | open -f -a /Applications/Preview.app/
  }
fi

# "${DOTFILES_DIR:-$HOME/Documents/config/dotfiles}/install.sh"

# mkdir and cd into it
function mkcd {
  mkdir -p "$@" && cd "$_"
}

# Recursively remove file name
function rm-rec {
  find . -type f -name "${1}" -ls -delete
}

# Get weather info
function weather {
  curl "wttr.in/${1}"
}

# Get succinct weather info
function weather-short {
  curl "wttr.in/${1}?format=3"
}

# Matrix-style screen-saver
function matrix {
    local lines=$(tput lines)
    cols=$(tput cols)

    awkscript='
    {
        letters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%^&*()"
        lines=$1
        random_col=$3
        c=$4
        letter=substr(letters,c,1)
        cols[random_col]=0;
        for (col in cols) {
            line=cols[col];
            cols[col]=cols[col]+1;
            printf "\033[%s;%sH\033[2;32m%s", line, col, letter;
            printf "\033[%s;%sH\033[1;37m%s\033[0;0H", cols[col], col, letter;
            if (cols[col] >= lines) {
                cols[col]=0;
            }
    }
}
'

echo -e "\e[1;40m"
clear

while :; do
    echo $lines $cols $(( $RANDOM % $cols)) $(( $RANDOM % 72 ))
    sleep 0.05
done | awk "$awkscript"
}

# Instagram movie function
# function square_movie {
#   ffmpeg -i $1 -an -vf "pad=max(iw\,ih):ow:(ow-iw)/2:(oh-ih)/2:color=white" $2
# }
