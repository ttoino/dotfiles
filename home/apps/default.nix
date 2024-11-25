{ pkgs, ... }: {
  imports = [
    ./git.nix
    ./kitty.nix
    ./lsd.nix
    ./neovim.nix
    ./vscode.nix
    ./xdg.nix
  ];

  programs = {
    # Browsers
    chromium.enable = true;
    firefox.enable = true;

    # CLI tools
    bat.enable = true;
    htop.enable = true;
    lf.enable = true;
    pistol.enable = true;
    ripgrep.enable = true;

    # Productivity
    obs-studio.enable = true;
    zathura.enable = true;

    # Utils
    imv.enable = true;
    mpv.enable = true;
  };

  services = {
    cliphist.enable = true;
    mpris-proxy.enable = true;
  };

  home.packages = with pkgs; [
    # Gaming
    prismlauncher

    # Messaging
    vesktop
    # (discord.override {
    #     # withOpenASAR = true;
    # #   css = "@import url(\"https://catppuccin.github.io/discord/dist/catppuccin-mocha-green.theme.css\");";
    # })

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
    nixpkgs-fmt
    pavucontrol
    playerctl
    soteria # Remove this once cmd-polkit is implemented
    unzip
    wdisplays
    wl-clipboard
  ];
}
