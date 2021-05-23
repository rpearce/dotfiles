{ pkgs, ... }:

let
  nerdfonts = pkgs.nerdfonts.override {
    fonts = [
      "FiraCode"
      "Hack"
      "Hasklig"
      #"Lilex"
      "SpaceMono"
    ];
  };
in {
  fonts = {
    enableFontDir = true;
    fonts = [
      nerdfonts
    ];
  };
}
