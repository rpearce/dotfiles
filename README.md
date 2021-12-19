# dotfiles

## macOS Usage

Run the installers to install Nix and Homebrew. If they are already installed
the installer won't run again.

```sh
λ ./installers/install_nix
λ ./installers/install_homebrew
```

### gpg

To sign your commits (which you should absolutely be doing), you'll need a gpg
key for your computer. You can check by:

```sh
λ gpg -K --keyid-format LONG
```

If nothing shows up, follow the steps here:

https://docs.github.com/en/github/authenticating-to-github/managing-commit-signature-verification/generating-a-new-gpg-key

Then take the key and set that as your signing key in your git config. Set it
like so in your `home-manager` `home.nix` (or equivalent) file:

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
λ nix build ".#darwinConfigurations.blueberry.system" --experimental-features "nix-command flakes"
λ ./result/sw/bin/darwin-rebuild switch --flake ".#blueberry"
```

If you have macOS system changes, you may need to restart for them to take
effect, or you need to kill the affected application (like "Dock"):

```sh
λ killall "Dock" &> /dev/null
```
