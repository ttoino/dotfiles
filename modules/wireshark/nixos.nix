{ username, ... }:
{
  programs.wireshark.enable = true;

  users.users.${username}.extraGroups = [ "wireshark" ];
}
