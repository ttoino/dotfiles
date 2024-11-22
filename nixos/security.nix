{ pkgs, ... }: {
  security = {
    pam.services.hyprlock.text = "auth        include     login";
    polkit.enable = true;

    # Allow rootless docker to bind to privileged ports
    # wrappers.docker-rootlesskit = {
    #   owner = "root";
    #   group = "root";
    #   capabilities = "cap_net_bind_service+ep";
    #   source = "${pkgs.rootlesskit}/bin/rootlesskit";
    # };
  };

  services.gnome.gnome-keyring.enable = true;
}
