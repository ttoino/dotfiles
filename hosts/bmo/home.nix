{ ... }:
{
  home.stateVersion = "24.05";

  age.rekey.localStorageDir = ./secrets/home;

  wayland.windowManager.hyprland.settings.monitorv2 = [
    {
      output = "eDP-2";
      mode = "preferred";
      position = "auto";
      scale = 1.333;
    }
    {
      output = "desc:Samsung Electric Company LC32G5xT H4ZR703681";
      mode = "preferred";
      position = "auto-left";
      scale = 1;
    }
    {
      output = "desc:LG Electronics LG ULTRAGEAR+ 502NTPC06960";
      mode = "preferred";
      position = "auto-left";
      scale = 1;
      bitdepth = 10;
      cm = "hdr";
      sdrbrightness = 1.25;
    }
    {
      output = "";
      mode = "preferred";
      position = "auto";
      scale = 1;
    }
  ];
}
