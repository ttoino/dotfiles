{ pkgs, ... }: {
  security = {
    pam.services.hyprlock = { };
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
