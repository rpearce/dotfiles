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
      nerdcommenter
      nerdtree
      supertab
      tabular
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
  };
}
