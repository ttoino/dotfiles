{ pkgs, ... }: {
  imports = [
    ./git.nix
    ./kitty.nix
    ./lsd.nix
    ./mopidy.nix
    ./neovim.nix
    ./xdg.nix
    ./yazi.nix
  ];

  programs = {
    bat.enable = true; # Cat clone
    chromium.enable = true; # Web browser
    firefox.enable = true; # Web browser
    htop.enable = true; # Process manager
    imv.enable = true; # Image viewer
    khal.enable = true; # Calendar
    khard.enable = true; # Contacts
    mpv.enable = true; # Video/audio player
    obs-studio.enable = true; # Screen recording/streaming
    ripgrep.enable = true; # Grep clone
    vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
    }; # Code editor
    zathura.enable = true; # PDF reader
  };

  services = {
    cliphist.enable = true; # Clipboard history
    mpris-proxy.enable = true; # Control media players with headset buttons
  };

  home.packages = with pkgs; [
    # cmd-polkit # TODO # Polkit agent
    blender-hip # 3D modeling
    blueberry # Bluetooth manager
    brightnessctl # Screen brightness control
    cliphist # Clipboard history
    d-spy # D-Bus inspector
    gimp # Image editor
    glow # Terminal markdown viewer
    grimblast # Screenshot tool
    hunspell # Spell checker
    hunspellDicts.pt_PT # Portuguese spell checker
    hyprland-qtutils # Needed by hyprland
    hyprpicker # Color picker
    hyprpolkitagent # Remove this once cmd-polkit is implemented # Polkit agent
    libnotify # Notification daemon
    libreoffice # Office suite
    nixpkgs-fmt # Nix formatter
    pavucontrol # Volume control
    playerctl # Media player control
    prismlauncher # Minecraft launcher
    tdf # Terminal pdf viewer
    unzip # Unzip files
    vesktop # Discord client
    vlc # Video player
    wdisplays # Display manager
    wl-clipboard # Clipboard manager
    zip # Zip files
  ];
}
