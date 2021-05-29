{ pkgs, ... }:

{
  programs.zsh ={
    enable = true;
    enableBashCompletion = true;
    enableCompletion = true;
    enableFzfCompletion = true;
    enableFzfGit = true;
    enableFzfHistory = true;
    enableSyntaxHighlighting = false;
    interactiveShellInit = ''
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      ${builtins.readFile ./.zshrc}
    '';
    promptInit = builtins.readFile ./.zshprompt;
  };
}
