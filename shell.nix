let
sources = import ./nix/sources.nix;

nixpkgs = sources."nixpkgs";

pkgs = import nixpkgs { };

hm = (import sources.home-manager { inherit pkgs; });

in pkgs.mkShell rec {
  name = "home-manager-shell";

  buildInputs = with pkgs; [
    niv
    hm.home-manager
  ];

  shellHook = ''
    export NIX_PATH="nixpkgs=${nixpkgs}:home-manager=${sources."home-manager"}"
    export HOME_MANAGER_CONFIG="./nix/home.nix"
  '';
}
