{ pkgs, ... }:

{
  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = "Robert Pearce";
    userEmail = "me@robertwpearce.com";
    #github = {
    #  user = "rpearce";
    #};
    signing = {
      key = "88E8DC924E5269C9";
      signByDefault = true;
    };
    aliases = {
      a = "add";
      amend = "commit --amend";
      c = "commit";
      ca = "commit --amend";
      ci = "commit -a";
      co = "checkout";
      d = "diff";
      dc = "diff --changed";
      ds = "diff --staged";
      f = "fetch";
      loll = "log --graph --decorate --pretty=oneline --abbrev-commit";
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
        pager = "diff-so-fancy | less --tabs=4 -RFX";
      };

      credential = {
        helper = "osxkeychain";
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
  };
}
