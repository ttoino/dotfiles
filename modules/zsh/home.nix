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
        src = pkgs.sources.zsh-fast-syntax-highlighting.src;
      }
      {
        name = "zsh-colored-man-pages";
        src = pkgs.sources.zsh-colored-man-pages.src;
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.sources.zsh-nix-shell.src;
      }
    ];

    initContent = ''
      ${builtins.readFile ./prompt.zsh}
    '';
  };
}
