{ pkgs, ... }: {
  programs = {
    # Browsers
    chromium.enable = true;
    firefox.enable = true;

    # CLI tools
    bat.enable = true;
    htop.enable = true;
    ripgrep.enable = true;

    # Messaging
    discocss = {
      enable = true;
      css = "@import url(\"https://catppuccin.github.io/discord/dist/catppuccin-mocha-green.theme.css\");";
    };

    # Productivity
    obs-studio.enable = true;
    zathura.enable = true;
  };

  services = {
    cliphist.enable = true;
    mpris-proxy.enable = true;
  };

  home.packages = with pkgs; [
    # Gaming
    prismlauncher

    # Productivity
    blender-hip
    gimp
    libreoffice
    hunspell
    hunspellDicts.pt_PT
    vlc

    # Utils
    blueberry
    brightnessctl
    cliphist
    # cmd-polkit # TODO
    d-spy
    grimblast
    hyprpicker
    libnotify
    pavucontrol
    playerctl
    soteria # Remove this once cmd-polkit is implemented
    unzip
    wdisplays
    wl-clipboard
  ];
}
