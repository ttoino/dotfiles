{ ... }:
{
  services = {
    displayManager.autoLogin.user = "toino";

    getty = {
      autologinUser = "toino";
      autologinOnce = true;
    };
  };
}
