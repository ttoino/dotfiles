{ modules, ... }:
{
  modules = with modules; [
    docker
    docs
    git
    neovim
    vscode
    ssh
  ];
}
