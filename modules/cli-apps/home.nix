{ pkgs, ... }:
{
  programs = {
    bat.enable = true; # Cat clone
    htop.enable = true; # Process manager
    obs-studio.enable = true; # Screen recording/streaming
    ripgrep.enable = true; # Grep clone

    zsh.shellAliases = {
      cat = "bat";
      less = "bat --paging=always";

      grep = "rg --hyperlink-format=kitty";
    };
  };

  home.packages = with pkgs; [
    glow # Terminal markdown viewer
    tdf # Terminal pdf viewer
    unzip # Unzip files
    zip # Zip files
  ];
}
