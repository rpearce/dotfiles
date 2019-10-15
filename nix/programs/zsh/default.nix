{ hostname, xdg, ... }:

{
  enable = true;

  autocd = false;
  enableAutosuggestions = true;

  sessionVariables = {
    CONFIG_HOSTNAME = hostname;
    EDITOR = "nvim";
    NPM_TOKEN = "`cat ~/.npmrc 2>/dev/null | grep authToken | tr \"=\" \"\\n\" | tail -n 1`";
    RIPGREP_CONFIG_PATH = ~/.ripgreprc;
    XDG_CACHE_HOME = xdg.cacheHome;
    XDG_CONFIG_HOME = xdg.configHome;
    XDG_DATA_HOME = xdg.dataHome;
  };

  shellAliases = {
    # Recursively remove Apple meta files
    cleanupds = "find . -type f -name '*.DS_Store' -ls -delete";
    cleanupad = "find . -type d -name '.AppleD*' -ls -exec /bin/rm -r {} \\;";

    # Docker
    dc = "docker-compose";
    dcr = "docker-compose run --rm \${1}";

    # bat > cat
    cat = "bat";

    # ncdu > du
    du = "ncdu --color dark -rr -x --exclude .git --exclude node_modules";

    # Network
    ip = "dig +short myip.opendns.com @resolver1.opendns.com";
    ipl = "ifconfig | grep -Eo 'inet (addr:)?([0-9]*\\.){3}[0-9]*' | grep -Eo '([0-9]*\\.){3}[0-9]*' | grep -v '127.0.0.1'";

    # long listing
    ll = "ls --color=auto -laG";

    # Run previous command with sudo
    please = "sudo \"$BASH\" -c \"$(history -p !!)\"";

    # Reload profile
    rel = "exec $SHELL -l";

    # Serve current dir
    srv = "ruby -run -e httpd . -p \${1:-3000}";

    # timetrack-cli
    tt = "timetrack-cli";

    # AntiVirus Scan: ClamAV
    vscan = "clamscan -ri --bell \${1}";
  };

  envExtra = builtins.readFile ./.zshenv;

  initExtra = builtins.readFile ./.zshrc;
}