{ config, pkgs, ... }:

{
  # Copy applications into ~/Applications/Nix Apps. This workaround allows us
  # to find applications installed by nix through spotlight.
  #system.activationScripts.applications.text = pkgs.lib.mkForce (
  #  ''
  #    rm -rf ~/Applications/Nix\ Apps
  #    mkdir -p ~/Applications/Nix\ Apps
  #    for app in $(find ${config.system.build.applications}/Applications -maxdepth 1 -type l); do
  #      src="$(/usr/bin/stat -f%Y "$app")"
  #      cp -rL "$src" ~/Applications/Nix\ Apps
  #    done
  #  ''
  #);
}
