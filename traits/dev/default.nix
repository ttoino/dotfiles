{ modules, ... }:
{
  modules = with modules; [
    direnv
    docker
    docs
    git
    neovim
    vscode
    ssh
  ];
}
