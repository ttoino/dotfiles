{ lib, pkgs, ... }:
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

  programs.zsh = {
    initContent = lib.mkAfter (builtins.readFile ./prompt.zsh);

    plugins = [
      {
        name = "git-aliases";
        file = "plugins/git/git.plugin.zsh";
        src = pkgs.sources.ohmyzsh.src;
      }
      {
        name = "gitstatus";
        file = "gitstatus.prompt.zsh";
        src = pkgs.sources.zsh-gitstatus.src;
      }
    ];
  };
}
