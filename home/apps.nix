{ pkgs, ... }: {
  programs = {
    # Browsers
    chromium.enable = true;
    firefox.enable = true;

    # CLI tools
    bat.enable = true;
    htop.enable = true;
    ripgrep.enable = true;
  };

  services = {
    cliphist.enable = true;
  };

  home.packages = with pkgs; [
    # Gaming
    prismlauncher

    # Utils
    brightnessctl
    cliphist
    # cmd-polkit # TODO
    grimblast
    hyprpicker
    playerctl
    soteria # Remove this once cmd-polkit is implemented
    wdisplays
    wl-clipboard
  ];
}
