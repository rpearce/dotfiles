run:
	@echo "# Applying home configuration"
	nix-channel --update
	home-manager switch
	nix-collect-garbage -d
