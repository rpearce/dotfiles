{ pkgs }:

let
  plugins = pkgs.vimPlugins // pkgs.callPackage ./custom-plugins.nix {};

in {
  enable = true;

  viAlias = true;
  vimAlias = true;

  configure = {
    customRC = builtins.readFile ./vimrc;

    plug.plugins = with plugins; [
      # Themes
      onedark-vim

      # Linting
      ale

      # Search
      ctrlp-vim
      vim-ripgrep

      # Tools
      coc-nvim
      nerdcommenter
      nerdtree
      supertab
      tlib_vim
      vim-addon-mw-utils
      vim-buffergator
      vim-css-color
      vim-easymotion
      vim-endwise
      vim-eunuch
      vim-fugitive
      vim-gitgutter
      vim-localvimrc
      vim-multiple-cursors
      vim-repeat
      vim-snipmate
      vim-surround
      vim-trailing-whitespace
      vim-vroom

      # Languages
      vim-stylish-haskell
      vim-polyglot
    ];
  };
}
