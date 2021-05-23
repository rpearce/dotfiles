{ fetchFromGithub, pkgs, sources }:

{
  moonlight-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "moonlight-nvim";
    src = fetchFromGithub {
      owner = "shaunsingh";
      repo ="moonlight.nvim";
      rev = "abc";
      sha256 = "def";
    };
  };

  nord-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "nord-nvim";
    src = fetchFromGithub {
      owner = "shaunsingh";
      repo ="nord.nvim";
      rev = "abc";
      sha256 = "def";
    };
  };
}
