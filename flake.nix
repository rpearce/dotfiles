{
  description = "Robert W. Pearce's system config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, darwin, flake-utils, home-manager, nixpkgs }:
    let
      nixpkgsConfig = with inputs; {
        config = {
          allowUnfree = true;
        };
        overlays = [];
      };

      mkDarwinConfig =
        { host
        , user
        }: [
          (./. + "/hosts/${host}/default.nix")
          home-manager.darwinModules.home-manager
          {
            nixpkgs = nixpkgsConfig;
            users.users.${user}.home = "/Users/${user}";
            home-manager.useUserPackages = true;
            home-manager.users.${user} = with self.homeManagerModules; {
              imports = [ (./. + "/hosts/${host}/users/${user}/default.nix") ];
            };
          }
        ];
    in {
      darwinConfigurations = {
        blueberry = darwin.lib.darwinSystem {
          inputs = inputs;
          modules = mkDarwinConfig {
            host = "blueberry";
            user = "rpearce";
          };
        };

        trabajo = darwin.lib.darwinSystem {
          inputs = inputs;
          modules = mkDarwinConfig {
            host = "trabajo";
            user = "rpearce";
          };
        };
      };
    };
}
