{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (iosevka.override (import ./iosevka.nix))
    material-design-icons
    material-symbols
    meterial-symbols
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    roboto
    # twitter-color-emoji is the fork of twemoji-color-font
    twitter-color-emoji
  ];

  fonts.fontconfig = {
    defaultFonts = {
      sansSerif = [
        "Roboto"
        "Noto Sans"
      ];
      serif = [ "Noto Serif" ];
      monospace = [
        "Iosevka Custom Extended"
        "Material Design Icons"
        "Material Symbols Outlined"
        "Meterial Symbols"
        "Roboto Mono"
        "Noto Sans Mono"
      ];
      emoji = [ "Twitter Color Emoji" ];
    };
  };
}
