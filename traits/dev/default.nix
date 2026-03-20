{ modules, ... }:
{
  modules = with modules; [
    android
    direnv
    docker
    docs
    git
    neovim
    opencode
    vscode
    ssh
    wireshark
  ];
}
