{ pkgs, ... }: {
  programs.zsh = {
    enable = true;

    history = {
      append = true;
      extended = true;
      save = 1000000000;
      share = true;
      size = 1000000000;
    };

    shellAliases = {
      # ls
      ls = "ls --color=auto --group-directories-first";
      ll = "ls -lh";
      la = "ls -A";
      lla = "ls -lhA";

      # misc
      q = "exit";
      ":q" = "exit";
      quit = "exit";
      pd = "popd";
      cat = "bat";
    };

    plugins = [
      {
        name = "fast-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zdharma-continuum";
          repo = "fast-syntax-highlighting";
          rev = "master";
          sha256 = "RVX9ZSzjBW3LpFs2W86lKI6vtcvDWP6EPxzeTcRZua4=";
        };
      }
      {
        name = "git-aliases";
        file = "plugins/git/git.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "ohmyzsh";
          repo = "ohmyzsh";
          rev = "master";
          sha256 = "JXEMx8+49xEH6xWRCTBMtwQ5DXhMjkBfzUMHKgr7j78=";
        };
      }
      {
        name = "gitstatus";
        file = "gitstatus.prompt.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "romkatv";
          repo = "gitstatus";
          rev = "master";
          sha256 = "MzDtVXnhSshxl+wZZbaq/UevRe6ZQWwkiPBeNqpZGOs=";
        };
      }
      {
        name = "zsh-colored-man-pages";
        src = pkgs.fetchFromGitHub {
          owner = "ael-code";
          repo = "zsh-colored-man-pages";
          rev = "master";
          sha256 = "087bNmB5gDUKoSriHIjXOVZiUG5+Dy9qv3D69E8GBhs=";
        };
      }
      {
        name = "zsh-fast-alias-tips";
        src = pkgs.fetchFromGitHub {
          owner = "decayofmind";
          repo = "zsh-fast-alias-tips";
          rev = "master";
          sha256 = "gXBg9GWgajpj8l63L2S22riGox9gvgZl9qmf+2nKwa4=";
        };
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "master";
          sha256 = "Rtg8kWVLhXRuD2/Ctbtgz9MQCtKZOLpAIdommZhXKdE=";
        };
      }
    ];

    initExtra = ''
      ${builtins.readFile ./completion.zsh}
      ${builtins.readFile ./functions.zsh}
      ${builtins.readFile ./keybinds.zsh}
      ${builtins.readFile ./opts.zsh}
      ${builtins.readFile ./prompt.zsh}
    '';

    profileExtra = ''
      if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
        exec Hyprland
      fi
    '';
  };
}
