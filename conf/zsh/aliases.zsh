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

# 1Password
if has_cmd op; then
  alias op-art="op run --no-masking -- art"
  alias op-npm="op run -- npm"
  alias op-terraform="op run -- terraform"
  alias op-yarn="op run -- yarn"
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

# md5sum-files-combined
#   Description:
#     Get md5 hashes of all files provided or within directories
#   Usage:
#     $ md5sum-files file1 file2 dir1 file3 dir2
#     30e75f2aa6088d7c821537236e7e5227
#     195c52359ef1fb0b1f08a29cd29a18c5
#     ece4a27751110898fc655576cbea7153
#     ...
function md5sum-files {
  local entries=("${@}")
  local sums=""

  for entry in ${entries}; do
    if [[ -f "${entry}" ]]; then
      sums+="$(md5sum "${entry}" | awk '{print $1}')\n"
    elif [[ -d "${entry}" ]]; then
      sums+="$(find "${entry}" -type f -exec md5sum '{}' \; | awk '{print $1}')\n"
    else
      echo "error: ${entry} is neither file nor directory; exiting..."
      return 1
    fi
  done

  echo -n "$sums"
}

# md5sum-files-combined
#   Description:
#     Get a combined md5 hash of all files provided or within directories
#   Usage:
#     $ md5sum-files-combined file1 file2 dir1 file3 dir2
#     4de262a8e7fab310c38cc19a51c01b1d
function md5sum-files-combined {
  local entries=("${@}")

  md5sum-files ${entries} | \
    sort | \
    md5sum | \
    awk '{print $1}'
}

# Get gzipped file size
function gz {
  local origsize=$(wc -c < "$1")
  local gzipsize=$(gzip -c "$1" | wc -c)
  local ratio=$(echo "$gzipsize * 100/ $origsize" | bc -l)
  local saved=$(echo "($origsize - $gzipsize) * 100/ $origsize" | bc -l)

  printf "orig: %d bytes\ngzip: %d bytes\nsave: %2.0f%% (%2.0f%%)\n" "$origsize" "$gzipsize" "$saved" "$ratio"
}

if is_mac; then
  # Open manpage as PDF on macOS
  function manpdf {
    man -t "${1}" | open -f -a /Applications/Preview.app/
  }
fi

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
