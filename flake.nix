{
  description = "Robert W. Pearce's nixified dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:rycee/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { flake-utils, home-manager, nixpkgs, self }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [];
        pkgs = import nixpkgs { inherit system overlays; };
        hm = (import home-manager { inherit pkgs; }).home-manager;
      in rec {
        defaultPackage = hm;

        apps.switch = flake-utils.lib.mkApp {
          drv = pkgs.writeShellScriptBin "switch" ''
            export NIX_PATH="nixpkgs=${nixpkgs}:home-manager=${home-manager}"
            export HOME_MANAGER_CONFIG="$PWD/nix/home.nix"
            home-manager switch
          '';
        };
      }
    );
}
