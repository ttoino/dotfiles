{
  programs.hyprlock = {
    enable = true;

    settings = {
      auth = {
        fingerprint.enabled = true;
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
