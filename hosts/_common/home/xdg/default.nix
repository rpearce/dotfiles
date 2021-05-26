{ config }:

let
  home_dir = "${config.home.homeDirectory}";
in rec {
  xdg = {
    enable = true;
    cacheHome = "${home_dir}/.cache";
    configHome = "${home_dir}/.config";
    dataHome = "${home_dir}/.data";
  };
}
