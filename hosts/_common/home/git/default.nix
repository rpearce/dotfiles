{ pkgs
, ...
}:

{
  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName  = "Robert W. Pearce";
    userEmail = "me@robertwpearce.com";

    signing = {
      # NOTE: `key` is set by user home files
      signByDefault = true;
      gpgPath = "gpg";
    };

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
      sw = "switch";
      unpushed = "log @{u}";
      wc = "whatchanged";
      wip = "rebase -i @{u}";
      zap = "fetch -p";
    };

    extraConfig = {
      color = {
        ui = true;
      };

      core = {
        editor = "vim";
        excludesfile = "$HOME/.config/git/ignore";
        fsmonitor = true;
        #hooksPath = "$HOME/.config/git/hooks";
        pager = "delta";
        untrackedcache = true;
      };

      credential = {
        helper = "osxkeychain";
      };

      delta = {
        features = "unobtrusive-line-numbers decorations";
        whitespace-error-style = "22 reverse";
        syntax-theme = "Monokai Extended Bright";
      };

      "delta \"unobtrusive-line-numbers\"" = {
        line-numbers = true;
        line-numbers-minus-style = "#444444";
        line-numbers-zero-style = "#444444";
        line-numbers-plus-style = "#444444";
        line-numbers-left-format = "{nm:>4}┊";
        line-numbers-right-format = "{np:>4}│";
        line-numbers-left-style = "#444444";
        line-numbers-right-style = "#444444";
      };

      "delta \"decorations\"" = {
        commit-decoration-style = "bold yellow box ul";
        file-style = "bold yellow ul";
        file-decoration-style = "none";
        hunk-header-decoration-style = "yellow box";
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

      init = {
        defaultBranch = "main";
      };

      interactive = {
        diffFilter = "delta --dark --color-only";
      };

      pull = {
        rebase = true;
      };
    };
  };
}
