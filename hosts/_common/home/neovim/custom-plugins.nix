{ fetchFromGitHub, pkgs }:

{
  moonlight-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "moonlight-nvim";
    src = fetchFromGitHub {
      owner = "shaunsingh";
      repo ="moonlight.nvim";
      rev = "e24e4218ec680b6396532808abf57ca0ada82e66";
      sha256 = "0m9w3fpypsqxydjd93arbjqb5576nl40iy27i4ijlrqhgdhl49y3";
    };
  };

  nord-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "nord-nvim";
    src = fetchFromGitHub {
      owner = "shaunsingh";
      repo ="nord.nvim";
      rev = "6860c64a3002f6dbcf36c0baf7bda8c34c5083c8";
      sha256 = "0a036xgsklqv2zwlcpyhdrip8mvgqhyb4vcsp7gwp5241917bia3";
    };
  };
}
