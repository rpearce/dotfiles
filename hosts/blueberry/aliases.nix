{
  environment.shellAliases = {
    # timetrack-cli
    #tt = "timetrack-cli";

    # AntiVirus Scan: ClamAV
    vscan = "freshclam && clamscan -ri --bell \${1}";
  };
}
