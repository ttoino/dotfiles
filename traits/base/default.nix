{ modules, ... }:
{
  modules = with modules; [
    base
    boot
    catppuccin
    cli-apps
    lsd
    secrets
    users
    yazi
    zsh
  ];
}
