home:
	@echo "# Applying home configuration"
	home-manager -f ./nixpkgs/home.nix switch
	nix-collect-garbage -d
