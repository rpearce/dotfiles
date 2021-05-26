{ home_dir }:

{
  enable = true;
  cacheHome = "${home_dir}/.cache";
  configHome = "${home_dir}/.config";
  dataHome = "${home_dir}/.data";
}
