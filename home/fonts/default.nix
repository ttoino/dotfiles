{ pkgs, ... }: {
  home.packages = with pkgs; [
    (iosevka.override (import ./iosevka.nix))
    noto-fonts
    roboto
    # twitter-color-emoji is the fork of twemoji-color-font
    twitter-color-emoji
    material-design-icons
  ];

  fonts.fontconfig = {
    defaultFonts = {
      sansSerif = [
        "Roboto"
        "Noto Sans"
      ];
      serif = [
        "Noto Serif"
      ];
      monospace = [
        "Iosevka Custom Extended"
        "Material Design Icons"
        "Roboto Mono"
        "Noto Sans Mono"
      ];
      emoji = [
        "Twitter Color Emoji"
      ];
    };
  };
}
