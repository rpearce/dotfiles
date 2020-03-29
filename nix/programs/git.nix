{ gitConfig
, pkgs
}:

{
  package = pkgs.gitAndTools.gitFull;
  enable = true;
  userName  = gitConfig.userName;
  userEmail = gitConfig.userEmail;

  signing = (if gitConfig.gpgKey != ""
             then {
                key = gitConfig.gpgKey;
                signByDefault = true;
                gpgPath = "gpg";
              }
              else { key = ""; }
            );

  aliases = {
    a = "add";
    amend = "commit --amend";
    branches = "for-each-ref --sort=-committerdate --format='%(color:cyan)%(authordate:relative)\t%(color:red)%(authorname)\t%(color:white)%(color:bold)%(refname:short)' refs/remotes";
    c = "commit";
    ca = "commit --amend";
    ci = "commit -a";
    co = "checkout";
    d = "diff";
    dc = "diff --changed";
    ds = "diff --staged";
    f = "fetch";
    loll = "log --abbrev-commit --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --";
    m = "merge";
    one = "log --pretty=oneline";
    outstanding = "rebase -i @{u}";
    praise = "blame";
    s = "status";
    unpushed = "log @{u}";
    wc = "whatchanged";
    wip = "rebase -i @{u}";
    zap = "fetch -p";
  };

  extraConfig = {
    color = {
      ui = true;
    };

    "color \"diff\"" = {
      meta = "yellow";
      frag = "magenta bold";
      commit = "yellow bold";
      old = "red bold";
      new = "green bold";
      whitespace = "red reverse";
    };

    "color \"diff-highlight\"" = {
      oldNormal = "red bold";
      oldHighlight = "red bold 52";
      newNormal = "green bold";
      newHighlight = "green bold 22";
    };

    core = {
      editor = "nvim";
      excludesfile = "~/.gitignore";
      #hooksPath = "~/.githooks";
      pager = "diff-so-fancy | less --tabs=4 -RFX";
    };

    credential = {
      helper = gitConfig.credentialHelper;
    };

    fetch = {
      prune = true;
    };

    grep = {
      lineNumber = true;
    };

    help = {
      autocorrect = 1;
    };
  };
}
