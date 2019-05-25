{
  allowUnfree = true;

  packageOverrides = super: let self = super.pkgs; in {
    timetrack-cli = super.haskellPackages.callPackage ./timetrack-cli/default.nix {};

    #haskellPackages = super.haskellPackages.override {
    #  overrides = self: super: {
    #    foo = self.callPackage ./foo.nix {};
    #  };
    #};
  };
}
