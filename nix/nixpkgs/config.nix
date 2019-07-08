{
  allowUnfree = true;

  packageOverrides = p: let hp = p.pkgs.haskellPackages; in {
    timetrack-cli = hp.callPackage ./timetrack-cli/default.nix { };

    #haskellPackages = super.haskellPackages.override {
    #  overrides = self: super: {
    #    foo = self.callPackage ./foo.nix {};
    #  };
    #};
  };
}
