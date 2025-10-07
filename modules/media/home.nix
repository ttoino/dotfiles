{ pkgs, ... }:
let
  beets = import ./beets-package.nix pkgs;
in
{
  programs.zsh.shellAliases = {
    beet = "sudo -u beets ${beets}/bin/beet";
  };
}
