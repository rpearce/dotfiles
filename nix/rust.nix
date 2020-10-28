{ sources ? import ./sources.nix }:

let
  pkgs = import sources.nixpkgs {
    overlays = [
      (import sources.nixpkgs-mozilla)
    ];
  };

  chan = (pkgs.rustChannelOf {
    date = "2020-10-24";
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
