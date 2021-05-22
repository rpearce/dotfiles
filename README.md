# dotfiles

## macOS Usage

### Installers

Run the installers to install Nix and Homebrew. If they are already installed
the installer won't run again.

```sh
λ ./installers/install_nix
λ ./installers/install_homebrew
```

Once nix is installed, open a new window and run this to get the latest nix
version:

```sh
nix-env -iA nixpkgs.nixUnstable
```

Next, make sure your `/etc/synthetic.conf` file has the following:

```
run	private/var/run
nix
```

If not, edit it to include those two lines (you may need to use `sudo vim
/etc/synthetic.conf` to be able to update the file).

Next, you need to give `/nix` permissions:

```sh
λ sudo chown -R my-user:staff /nix
```

### Building and running a flake

If we have a `darwinConfigurations.blueberry` flake (see `flake.nix`), then we
can build that and run `switch`.

_Note: If you already have `experimental-features` set in a `nix.conf` file with
`nix-command` and `flakes` as the value, then you don't need the
`--experimental-features` flag passed `nix build` below._

```sh
λ nix build ".#darwinConfigurations.blueberry.system" --show-trace --experimental-features "nix-command flakes"
λ ./result/sw/bin/darwin-rebuild switch --flake ".#blueberry"
```
