{ pkgs, ... }:

let
  nerdfonts = pkgs.nerdfonts.override {
    fonts = [
      "FiraCode"
      "Hack"
      "Hasklig"
      "Lilex"
      "SpaceMono"
      "SourceCodePro"
    ];
  };
in {
  fonts = {
    fontDir.enable = true;
    fonts = [
      nerdfonts
    ];
  };
}
