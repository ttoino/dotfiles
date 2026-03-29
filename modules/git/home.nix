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
        rev = "76ffd9e22acc7f11ca501f03d6999adbdb9baa61";
        hash = "sha256-1E/jENGDp7ZsWX5URjmD0x7ccnGbij7O0FshOS3FxRU=";
      };
    }
    {
      name = "gitstatus";
      file = "gitstatus.prompt.zsh";
      src = pkgs.fetchFromGitHub {
        owner = "romkatv";
        repo = "gitstatus";
        rev = "075baf6ecb19f58b09c9562f33c20b842e870961";
        hash = "sha256-KkSXHzsEeFOBCYGiPV6hdWEESEEfhNXI8SFRFze7/KM=";
      };
    }
  ];
}
