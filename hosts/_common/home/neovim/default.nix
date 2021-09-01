{ pkgs
, ...
}:

let
  vimPlugins = pkgs.vimPlugins // pkgs.callPackage ./custom-plugins.nix {};
in {
  programs.neovim = {
    enable = true;

    extraConfig = builtins.readFile ./vimrc;

    plugins = with vimPlugins; [
      # Themes
      dracula-vim
      moonlight-nvim
      nord-nvim
      onedark-vim

      # Linting
      ale

      # Search
      ctrlp-vim
      fzf-vim
      #vim-ripgrep

      # Tools
      coc-nvim
      nerdtree
      tabular
      vim-buffergator
      vim-css-color
      vim-fugitive
      vim-gitgutter
      vim-localvimrc
      vim-surround
      #nerdcommenter
      #supertab
      #vim-multiple-cursors
      #vim-trailing-whitespace

      # Languages
      vim-polyglot
    ];

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
