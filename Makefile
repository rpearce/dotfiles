run:
	@echo "# Applying home configuration"
	nix-channel --update
	home-manager -f ./home.nix switch
	nix-collect-garbage -d
