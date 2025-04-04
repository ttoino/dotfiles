{ modules, ... }:
{
  modules = with modules; [
    android
    direnv
    docker
    docs
    git
    neovim
    vscode
    ssh
    wireshark
  ];
}
