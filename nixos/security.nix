{ ... }: {
  security = {
    pam.services.hyprlock = { };
    polkit.enable = true;
  };

  services.gnome.gnome-keyring.enable = true;
}
