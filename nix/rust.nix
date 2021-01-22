{ sources ? import ./sources.nix }:

let
  pkgs = import sources.nixpkgs {
    overlays = [
      (import sources.rust-overlay)
    ];
  };

  chan = (pkgs.rustChannelOf {
    date = "2021-01-15";
    channel = "nightly";
  }).rust.override {
    targets = [ ];
    extensions = [
      "clippy-preview"
      "rust-src"
      "rustc-dev"
      "rustfmt-preview"
    ];
  };

in chan
