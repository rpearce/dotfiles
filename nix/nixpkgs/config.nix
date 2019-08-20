{
  allowBroken = true;
  allowUnfree = true;

  packageOverrides = pkgs: rec {
    timetrack-cli = pkgs.haskellPackages.callPackage ./timetrack-cli/default.nix { };

    haskellPackages = pkgs.haskellPackages.override {
      overrides = hpNew: hpOld: rec {
        #foo = hpNew.callPackage /path/to/default.nix { };
      };
    };
  };
}
