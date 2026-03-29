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
          rev = "3d574ccf48804b10dca52625df13da5edae7f553";
          hash = "sha256-ZihUL4JAVk9V+IELSakytlb24BvEEJ161CQEHZYYoSA=";
        };
      }
      {
        name = "zsh-colored-man-pages";
        src = pkgs.fetchFromGitHub {
          owner = "ael-code";
          repo = "zsh-colored-man-pages";
          rev = "57bdda68e52a09075352b18fa3ca21abd31df4cb";
          hash = "sha256-087bNmB5gDUKoSriHIjXOVZiUG5+Dy9qv3D69E8GBhs=";
        };
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "82ca15e638cc208e6d8368e34a1625ed75e08f90";
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
