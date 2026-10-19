{ username, ... }:
{
  services = {
    displayManager.autoLogin.user = username;

    getty = {
      autologinUser = username;
      autologinOnce = true;
    };
  };
}
