{ pkgs, ... }:
{
  home.packages = with pkgs; [ wireshark-qt ];
}
