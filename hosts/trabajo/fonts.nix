{ pkgs, ... }:

{
  fonts = {
    enableFontDir = true;
    fonts = [
      pkgs.nerdfonts
    ];
  };
}
