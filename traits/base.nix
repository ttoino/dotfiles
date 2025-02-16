{ modules, ... }:
{
  modules = with modules; [
    base
    catppuccin
    lsd
    secrets
    yazi
    zsh
  ];

  home = [ ];

  nixos = [ ];
}
