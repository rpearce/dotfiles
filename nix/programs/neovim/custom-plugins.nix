{ pkgs, sources }:

{
  onedark-vim = pkgs.vimUtils.buildVimPlugin {
    name = "onedark-vim";
    src = sources.onedark-vim;
  };

  vim-ripgrep = pkgs.vimUtils.buildVimPlugin {
    name = "vim-ripgrep";
    src = sources.vim-ripgrep;
  };
}
