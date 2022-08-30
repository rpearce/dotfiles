# dotfiles

This macOS-centric dotfiles repo uses
[nix-darwin](https://github.com/LnL7/nix-darwin/) to manage all the system
settings, CLI tools, applications, etc, across different machines.

Feel free to use — and improve on — any code you find in this repo that might
help you 🙇.

## Setup & Run

```sh
./installers/install_nix
./installers/install_homebrew
CFG=sietch ./build
```

For this last line, if we have a `darwinConfigurations.sietch` config (see
[`flake.nix`](./flake.nix)), then that is the config we are looking to use, and
we specify it via `CFG` for our simple `./build` script.

If we have macOS system changes, we may need to restart for them to take
effect, or we'll need to kill the affected application (like "Dock"):

```sh
killall "Dock" &> /dev/null
```

## gpg

To sign commits, we'll need a gpg key for your computer. We can check by:

```sh
gpg --list-secret-keys --keyid-format=long
```

If nothing shows up, follow the steps here:

https://docs.github.com/en/github/authenticating-to-github/managing-commit-signature-verification/generating-a-new-gpg-key

Then take the key and set that as our signing key in our git config. Set it
like so in our `home-manager` `home.nix` (or equivalent) file:

```nix
programs.git.signing.key = "my-key-here";
```
