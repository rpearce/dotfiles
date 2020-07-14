# dotfiles

My dotfiles config. Inspired in part by:
* https://github.com/utdemir/dotfiles/
* https://github.com/ryantm/home-manager-template

## Setup

1. `λ cp env-example env`
1. Adjust the exported variables in `env` (see [the environment variables
   section](#environment-variables) below
1. `λ ./make setup` (and see the [usage](#usage) below)

## Usage

```
Usage: ./make <COMMAND>
  clean     (-d)           Collect nix garbage and optimise the store
  brewup                   Run brew commands
  help      (-h|--help)    Read this usage
  hm                       Run home-manager
  setup                    Install nix, run home-manager, install homebrew, load
                           your Brewfile, load macOS-specific options
  switch                   Run home-manager switch with options
  update                   Update and upgrade dependencies
```

## Environment variables
You should have `BREWFILE_PATH` and `HOME_MANAGER_CONFIG` configured somewhere
when commands are run. They can already be exported in your shell, or included
when running a command like

```bash
BREWFILE_PATH="./homebrew/HomeBrewfile" HOME_MANAGER_CONFIG="./nix/home.nix" ./make update
```

or exported from the `env` file that is automatically sourced when running
commands (this is the preferred way):

```bash
export BREWFILE_PATH="path/to/Brewfile"
export HOME_MANAGER_CONFIG="path/to/config.nix"
```
