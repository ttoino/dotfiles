{ lib, ... }:
{
  programs.zsh = {
    enable = true;

    shellAliases = {
      # CLI tools
      ll = lib.mkForce "ls -lh";
      la = lib.mkForce "ls -A";
      lla = lib.mkForce "ll -A";

      # nix
      ns = "nix-shell";
      nsp = "ns --packages";
      nr = "sudo nixos-rebuild";
      nrs = "nr switch";
      nrsf = "nrs --flake";

      # misc
      q = "exit";
      ":q" = "exit";
      quit = "exit";
      pd = "popd";
    };
  };
}
