{ pkgs, ... }: {
  home.packages = with pkgs; [
    (iosevka.override (import ./iosevka.nix))
    noto-fonts
    roboto
    twemoji-color-font
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
    };
  };
}
