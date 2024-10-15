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

  home.packages = with pkgs; [
    # Gaming
    prismlauncher
  ];
}
