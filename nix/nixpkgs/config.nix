{
  allowBroken = true;
  allowUnfree = true;

  packageOverrides = pkgs: rec {
    timetrack-cli = pkgs.haskellPackages.callPackage ./timetrack-cli/default.nix { };

    haskellPackages = pkgs.haskellPackages.override {
      overrides = hpNew: hpOld: rec {
        #foo = hpNew.callPackage /path/to/default.nix { };

        # HsYAML-aeson & stylish-haskell overrides are
        # tied together and are from https://github.com/NixOS/nixpkgs/pull/79528/files

        #HsYAML-aeson = hpOld.HsYAML-aeson.override {
        #  HsYAML = hpNew.HsYAML_0_2_1_0;
        #};

        #stylish-haskell = hpOld.stylish-haskell.override {
        #  HsYAML = hpNew.HsYAML_0_2_1_0;
        #};
      };
    };
  };
}
