{
  homeArgs,
  homeModules,
  inputs,
  username,
  ...
}:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = homeArgs;
    users.${username}.imports = homeModules;
  };
}
