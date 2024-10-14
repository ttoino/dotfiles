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
      # CLI tools
      cat = "bat";

      diff = "kitten diff";

      less = "bat --paging=always";

      ls = "eza --color=auto --group-directories-first";
      ll = "ls -lh";
      la = "ls -A";
      lla = "ls -lhA";

      grep = "rg --hyperlink-format=kitty";

      icat = "kitten icat";

      ssh = "kitten ssh";

      # nix
      ns = "nix-shell";
      nsp = "ns --packages";
      nr = "sudo nixos-rebuild";
      nrs = "nr switch";
      nrsf = "nrs --flake";

      # misc
      q = "exit";
      ":q" = "exit";
      quit = "exit";
      pd = "popd";
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
        name = "git-aliases";
        file = "plugins/git/git.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "ohmyzsh";
          repo = "ohmyzsh";
          rev = "master";
          hash = "sha256-JXEMx8+49xEH6xWRCTBMtwQ5DXhMjkBfzUMHKgr7j78=";
        };
      }
      {
        name = "gitstatus";
        file = "gitstatus.prompt.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "romkatv";
          repo = "gitstatus";
          rev = "master";
          hash = "sha256-MzDtVXnhSshxl+wZZbaq/UevRe6ZQWwkiPBeNqpZGOs=";
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

    initExtraFirst = ''
      ${builtins.readFile ./functions.zsh}
      ${builtins.readFile ./keybinds.zsh}
      ${builtins.readFile ./opts.zsh}
    '';

    completionInit = ''
      ${builtins.readFile ./completion.zsh}
    '';

    initExtra = ''
      ${builtins.readFile ./prompt.zsh}
    '';

    profileExtra = ''
      if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
        exec Hyprland
      fi
    '';
  };
}
