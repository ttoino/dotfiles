{ pkgs, ... }:
{
  programs = {
    chromium.enable = true; # Web browser
    firefox.enable = true; # Web browser
    imv.enable = true; # Image viewer
    mpv.enable = true; # Video/audio player
    zathura.enable = true; # PDF reader
  };

  home.packages = with pkgs; [
    blender-hip # 3D modeling
    blueberry # Bluetooth manager
    d-spy # D-Bus inspector
    gimp # Image editor
    hunspell # Spell checker
    hunspellDicts.pt_PT # Portuguese spell checker
    libreoffice # Office suite
    pavucontrol # Volume control
    vesktop # Discord client
    wdisplays # Display configuration
  ];
}
