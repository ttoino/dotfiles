{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        enable_fingerprint = true;
      };

      background = [
        {
          path = "screenshot";
          blur_size = 8;
          blur_passes = 3;
        }
      ];
    };
  };
}
