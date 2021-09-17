{ fetchFromGitHub, pkgs }:

{
  #moonlight-nvim = pkgs.vimUtils.buildVimPlugin {
  #  name = "moonlight-nvim";
  #  src = fetchFromGitHub {
  #    owner = "shaunsingh";
  #    repo ="moonlight.nvim";
  #    rev = "e24e4218ec680b6396532808abf57ca0ada82e66";
  #    sha256 = "0m9w3fpypsqxydjd93arbjqb5576nl40iy27i4ijlrqhgdhl49y3";
  #  };
  #};
}
