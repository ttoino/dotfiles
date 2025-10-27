{ pkgs, ... }:
{
  programs.git = {
    enable = true;

    lfs.enable = true;
    maintenance.enable = true;

    settings = {
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

      user = {
        name = "toino";
        email = "me@toino.pt";
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
        hash = "sha256-F3ixcEFzJEMXppkZN70uVVmDsgiwI7iJO3B/vezGmfI=";
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
