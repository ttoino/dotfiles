{ lib, pkgs, ... }:
{
  home.shell.enableZshIntegration = true;

  programs.zsh = {
    history = {
      append = true;
      extended = true;
      save = 1000000000;
      share = true;
      size = 1000000000;
    };

    shellAliases = {
      # Doesn't make sense in common.nix
      rr = "source ~/.zshrc";
    };

    plugins = [
      {
        name = "fast-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zdharma-continuum";
          repo = "fast-syntax-highlighting";
          rev = "master";
          hash = "sha256-RVX9ZSzjBW3LpFs2W86lKI6vtcvDWP6EPxzeTcRZua4=";
        };
      }
      {
        name = "zsh-colored-man-pages";
        src = pkgs.fetchFromGitHub {
          owner = "ael-code";
          repo = "zsh-colored-man-pages";
          rev = "master";
          hash = "sha256-087bNmB5gDUKoSriHIjXOVZiUG5+Dy9qv3D69E8GBhs=";
        };
      }
      {
        name = "zsh-fast-alias-tips";
        src = pkgs.fetchzip {
          url = "https://github.com/decayofmind/zsh-fast-alias-tips/releases/download/v1.0.0/zsh-fast-alias-tips_1.0.0_linux_amd64.tar.gz";
          stripRoot = false;
          hash = "sha256-W6LskHcJojB9eHsVJX4rbx5I9qJ4k0yKJS12FdGdTUg=";
        };
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "master";
          hash = "sha256-Rtg8kWVLhXRuD2/Ctbtgz9MQCtKZOLpAIdommZhXKdE=";
        };
      }
    ];

    completionInit = ''
      ${builtins.readFile ./completion.zsh}
    '';

    initContent = lib.mkMerge [
      (lib.mkBefore ''
        ${builtins.readFile ./functions.zsh}
        ${builtins.readFile ./keybinds.zsh}
        ${builtins.readFile ./opts.zsh}
      '')
      (''
        ${builtins.readFile ./prompt.zsh}
      '')
    ];
  };
}
