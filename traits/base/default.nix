{ modules, ... }:
{
  modules = with modules; [
    base
    boot
    btrbk
    catppuccin
    cli-apps
    lsd
    secrets
    users
    yazi
    zsh
  ];
}
