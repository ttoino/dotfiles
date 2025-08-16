{ pkgs, ... }:
{
  programs.git = {
    enable = true;

    userName = "toino";
    userEmail = "me@toino.pt";

    lfs.enable = true;
    maintenance.enable = true;

    extraConfig = {
      init.defaultBranch = "main";

      diff = {
        tool = "kitty";
        guitool = "kitty";
      };

      difftool = {
        prompt = false;
        trustExitCode = true;

        kitty = {
          cmd = "kitten diff $LOCAL $REMOTE";
        };
      };
    };
  };

  programs.zsh.plugins = [
    {
      name = "git-aliases";
      file = "plugins/git/git.plugin.zsh";
      src = pkgs.fetchFromGitHub {
        owner = "ohmyzsh";
        repo = "ohmyzsh";
        rev = "master";
        hash = "sha256-fCAwg6fzXw/mEa+xEnSCK88/ba8nR0FNY2tQ62CchbQ=";
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
  ];
}
