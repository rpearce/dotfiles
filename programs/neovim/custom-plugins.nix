{ pkgs, ... }:

{
  onedark-vim = pkgs.vimUtils.buildVimPlugin {
    name = "onedark-vim";
    src = pkgs.fetchFromGitHub {
      owner = "joshdick";
      repo = "onedark.vim";
      rev = "7f36f83f13d3bdbd3dca4e3e8b2a10a5ecdca5e9";
      sha256 = "0cnn3j3invasqh5sn20gf9lvcksqhracrbyr3pn3fs9shp7f1kxw";
    };
  };

  vim-endwise = pkgs.vimUtils.buildVimPlugin {
    name = "vim-endwise";
    src = pkgs.fetchFromGitHub {
      owner = "tpope";
      repo = "vim-endwise";
      rev = "f67d022169bd04d3c000f47b1c03bfcbc4209470";
      sha256 = "0lq2sphh2mfciva184b4b3if202hr4yls4d2gzbjx7ibch45zb9i";
    };
  };

  vim-vroom = pkgs.vimUtils.buildVimPlugin {
    name = "vim-vroom";
    src = pkgs.fetchFromGitHub {
      owner = "skalnik";
      repo = "vim-vroom";
      rev = "50028aff43ac516a9e038d2a9675c21891d5fb19";
      sha256 = "1q3ih3f9rnjykxslzbv8iz9kbfn81iamcfkdzdcfihh72cbz9gd9";
    };
  };
}
