{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.slskd;
in
{
  services.slskd = {
    enable = true;
    group = "media";
    environmentFile = config.age.secrets.slskd-env.path;
    domain = null;

    settings = {
      shares.directories = [ ];
      directories = {
        incomplete = "/data/downloads/soulseek/incomplete";
        downloads = "/data/downloads/soulseek/complete";
      };
      permissions.file.mode = "775";
      web.authentication.api_keys.media.key = "@api_key@";
    };
  };

  systemd.services.slskd.serviceConfig = {
    ExecStart = lib.mkForce "${cfg.package}/bin/slskd --app-dir /var/lib/slskd";
    UMask = "0002";
  };

  services.caddy.virtualHosts."soulseek.toino.pt".extraConfig = "reverse_proxy * localhost:5030";

  networking.hosts."127.0.0.1" = [ "soulseek.toino.pt" ];

  age.secrets = {
    slskd-env = {
      rekeyFile = ./slskd_env.age;
      owner = cfg.user;
      group = cfg.group;
    };
    slskd-api-key = {
      generator.script = "alnum";
      rekeyFile = ./slskd_api_key.age;
      owner = cfg.user;
      group = cfg.group;
    };
  };

  system.activationScripts.slskd =
    let
      configFile = lib.generators.toYAML { } (
        lib.filterAttrsRecursive (
          key: value: (builtins.tryEval value).success && value != null
        ) cfg.settings
      );
    in
    ''
      mkdir -p /var/lib/slskd

      cat >/var/lib/slskd/slskd.yml <<-EOF
      ${configFile}
      EOF

      chown -R ${cfg.user}:${cfg.group} /var/lib/slskd
      chmod -R 0775 /var/lib/slskd

      api_key=$(cat "${config.age.secrets.slskd-api-key.path}")
      ${pkgs.gnused}/bin/sed -i "s/@api_key@/$api_key/g" /var/lib/slskd/slskd.yml
    '';
}
