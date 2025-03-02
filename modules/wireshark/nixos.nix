{
  programs.wireshark.enable = true;

  users.users.toino.extraGroups = [ "wireshark" ];
}
