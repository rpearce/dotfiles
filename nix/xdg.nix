let
  home_dir = builtins.getEnv "HOME";

in rec {
  enable = true;
  configHome = "${home_dir}/.config";
  dataHome = "${home_dir}/Dropbox/.data";
  cacheHome = "${home_dir}/.cache";
}
