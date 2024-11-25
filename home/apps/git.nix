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
}
