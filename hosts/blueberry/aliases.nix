{
  environment.shellAliases = {
    # bat > cat
    cat = "bat";

    # Recursively remove Apple meta files
    cleanupds = "find . -type f -name '*.DS_Store' -ls -delete";

    # Get YYYY-MM-DD date
    date_ymd = "date +%Y-%m-%d";

    # Docker
    dc = "docker-compose";
    dcr = "docker-compose run --rm \${1}";
    dcrp = "dcr postgres psql postgresql://postgres@postgres:5432";

    # ncdu > du
    du = "ncdu --color dark -rr -x --exclude .git --exclude node_modules";

    # gpg
    gpgkill = "gpgconf --kill gpg-agent";

    # Network
    ip = "dig +short myip.opendns.com @resolver1.opendns.com";
    ipl = "ifconfig | grep -Eo 'inet (addr:)?([0-9]*\\.){3}[0-9]*' | grep -Eo '([0-9]*\\.){3}[0-9]*' | grep -v '127.0.0.1'";

    # caffeinate
    kaffe = "caffeinate -dusw $$";

    # long listing
    #ll = "ls --color=auto -laG";
    ls = "exa -G  --color auto --icons -a -s type";
    ll = "exa -l --color always --icons -a -s type";

    mk = "mkdir -p \"$@\" && cd $_";

    # Reload profile
    rel = ". ~/.zshrc";

    # Serve current dir
    srv = "python -m SimpleHTTPServer \$\{1:-8000\}";

    # Get YYYY-MM-DDTHH:MM:SSZ timestamp
    timestamp = "date +%Y-%m-%dT%H:%M:%SZ";

    # timetrack-cli
    #tt = "timetrack-cli";

    # AntiVirus Scan: ClamAV
    vscan = "freshclam && clamscan -ri --bell \${1}";

    # Get the weather
    weather = "curl \"wttr.in/\${1}\"";
  };
}
