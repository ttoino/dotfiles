{
  nixpkgs.config.android_sdk.accept_license = true;

  users.users.toino.extraGroups = [ "adbusers" ];
}
