{ username, ... }:
{
  nixpkgs.config.android_sdk.accept_license = true;

  users.users.${username}.extraGroups = [ "adbusers" ];
}
