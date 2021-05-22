# dotfiles

## macOS Usage

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

### gpg

To sign your commits, you'll need a gpg key for your computer. You can check by

```sh
λ gpg -K --keyid-format LONG
```

If nothing shows up,

```sh
λ gpg --generate-key
```

Then take the key (the second part of the `rsa3072/<key>` line) and set that as
your signing key in your git config. If using `home-manager` in here, set it
like so:

```nix
programs.git.signing.key = "my-key-here";
```

### `zsh-completions`

If using `zsh-completions`, you may run into this warning:

```sh
zsh compinit: insecure directories, run compaudit for list.
```

The solution to this comes from https://github.com/zsh-users/zsh-completions/issues/433#issuecomment-619321054.

Run `compaudit`, and if it's only `zsh`-related things, it should be safe to run
the following:

```sh
compaudit | xargs chmod g-w
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

If you have macOS system changes, you may need to restart for them to take
effect, or you need to kill the affected application (like "Dock"):

```sh
λ killall "Dock" &> /dev/null
```
