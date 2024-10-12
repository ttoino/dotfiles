{
  programs.git = {
    enable = true;

    userName = "toino";
    userEmail = "me@toino.pt";

    delta.enable = true;
    lfs.enable = true;

    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
