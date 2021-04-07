{ sources ? import ./sources.nix }:

let
  pkgs = import sources.nixpkgs {
    overlays = [
      (import sources.rust-overlay)
    ];
  };

in
  pkgs.rust-bin.stable.latest.default.override {
    targets = [ ];
    extensions = [
      "clippy-preview"
      "rust-src"
      "rustc-dev"
      "rustfmt-preview"
    ];
  }
