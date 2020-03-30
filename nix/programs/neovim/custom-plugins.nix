{ pkgs }:

{
  onedark-vim = pkgs.vimUtils.buildVimPlugin {
    name = "onedark-vim";
    src = pkgs.fetchFromGitHub {
      owner = "joshdick";
      repo = "onedark.vim";
      rev = "caa878801495aaf54e57d214486ef983a429d822";
      sha256 = "0bgfwidrlaqxnjmk14gqc8b0mxh0c5xf098qcjz9mvw236n88xl7";
    };
  };

  vim-endwise = pkgs.vimUtils.buildVimPlugin {
    name = "vim-endwise";
    src = pkgs.fetchFromGitHub {
      owner = "tpope";
      repo = "vim-endwise";
      rev = "bf90d8be447de667f4532b934d1a70881be56dd8";
      sha256 = "1czx891via5783yk222mhki94wvq75hxxp1xk1d5m90vwqb3azfn";
    };
  };

  vim-ripgrep = pkgs.vimUtils.buildVimPlugin {
    name = "vim-ripgrep";
    src = pkgs.fetchFromGitHub {
      owner = "jremmen";
      repo = "vim-ripgrep";
      rev = "ec87af6b69387abb3c4449ce8c4040d2d00d745e";
      sha256 = "1by56rflr0bmnjvcvaa9r228zyrmxwfkzkclxvdfscm7l7n7jnmh";
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
