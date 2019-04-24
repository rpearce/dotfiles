export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH

if [ -e /Users/rpearce/.nix-profile/etc/profile.d/nix.sh ]; then
  . /Users/rpearce/.nix-profile/etc/profile.d/nix.sh;
fi
