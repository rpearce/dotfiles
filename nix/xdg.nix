let
  home_dir = builtins.getEnv "HOME";

in {
  enable = true;
  configHome = "${home_dir}/.config";
  dataHome = "${home_dir}/.data";
  cacheHome = "${home_dir}/.cache";
}
