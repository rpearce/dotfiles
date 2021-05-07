{ pkgs }:

let
  plugins = pkgs.vimPlugins;

in {
  enable = true;

  extraConfig = builtins.readFile ./vimrc;

  plugins = with plugins; [
    # Themes
    onedark-vim

    # Linting
    ale

    # Search
    ctrlp-vim
    fzf-vim
    #vim-ripgrep

    # Tools
    coc-nvim
    nerdcommenter
    nerdtree
    supertab
    vim-buffergator
    vim-css-color
    vim-fugitive
    vim-gitgutter
    vim-localvimrc
    vim-multiple-cursors
    #vim-ormolu
    vim-surround
    vim-trailing-whitespace

    # Languages
    #vim-stylish-haskell
    vim-polyglot
  ];

  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;
}
