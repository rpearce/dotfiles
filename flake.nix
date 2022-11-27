{
  description = "Robert W. Pearce's system config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devenv.url = "github:cachix/devenv/v0.4";

    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @
  { self
  , darwin
  , devenv
  , flake-utils
  , home-manager
  , nixpkgs
  }:
    let
      mkNixpkgsConfig =
        { system
        }: {
          config = {
            allowUnfree = true;
          };
          overlays = [
            (final: prev: {
              devenv = devenv.packages.${system}.devenv;
            })
          ];
        };

      mkDarwinConfig =
        { system
        , host
        , user
        }:
          let
            nixpkgsConfig = mkNixpkgsConfig { inherit system; };
          in
            darwin.lib.darwinSystem {
              inherit system;

              modules = [
                (./. + "/hosts/${host}")
                home-manager.darwinModules.home-manager
                {
                  nixpkgs = nixpkgsConfig;
                  users.users.${user}.home = "/Users/${user}";
                  home-manager.useUserPackages = true;
                  home-manager.users.${user} = with self.homeManagerModules; {
                    imports = [ (./. + "/hosts/${host}/users/${user}") ];
                    nixpkgs.overlays = nixpkgsConfig.overlays;
                  };
                }
              ];

              specialArgs = { inherit self inputs nixpkgs; };
            };

    in {
      darwinConfigurations = {
        sietch = mkDarwinConfig {
          system = "aarch64-darwin";
          host = "sietch";
          user = "bobert";
        };

        vinna = mkDarwinConfig {
          system = "aarch64-darwin";
          host = "vinna";
          user = "bobert";
        };
      };
    };
}
