{ pkgs, ... }:

{
  onedark-vim = pkgs.vimUtils.buildVimPlugin {
    name = "onedark-vim";
    src = pkgs.fetchFromGitHub {
      owner = "joshdick";
      repo = "onedark.vim";
      rev = "2b0e71843eb022efd42428873841cb911a504195";
      sha256 = "0ygwzdbv72gqdy2ks24m7bbangn0k83ihgm4817888vy1i6j9ihk";
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
