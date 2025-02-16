{ modules, ... }:
{
  modules = with modules; [
    base
    boot
    catppuccin
    lsd
    secrets
    users
    yazi
    zsh
  ];
}
