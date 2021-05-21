# dotfiles

## Usage

### Installers

Run the installers to install Nix and Homebrew. If they are already installed
the installer won't run again.

```sh
λ ./installers/install_nix
λ ./installers/install_homebrew
```

Once nix is installed, open a new window and run this to get access to nix
flakes:

```sh
nix-env -iA nixpkgs.nixUnstable
```

### Building and running a flake

If we have a `darwinConfigurations.blueberry` flake (see `flake.nix`), then we
can build that and run `switch` like so:

```sh
λ nix build ".#darwinConfigurations.blueberry.system" --show-trace
λ ./result/sw/bin/darwin-rebuild switch --flake ".#blueberry"
```
