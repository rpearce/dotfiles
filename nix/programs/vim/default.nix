{ pkgs, sources }:

let
  plugins = pkgs.vimPlugins // pkgs.callPackage ./custom-plugins.nix { sources = sources; };

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
    vim-ripgrep

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
    vim-ormolu
    vim-surround
    vim-trailing-whitespace

    # Languages
    vim-stylish-haskell
    vim-polyglot
  ];
}
