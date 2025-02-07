{ inputs, pkgs, ... }:
{
  imports = [
    inputs.agenix.homeManagerModules.default
    inputs.agenix-rekey.homeManagerModules.default
  ];

  home.packages = [
    inputs.agenix-rekey.packages.${pkgs.system}.default
  ];

  age = {
    identityPaths = ["/home/toino/.ssh/id_ed25519"];

    rekey = {
      hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL8sBfh3Y90/+Za1gdqVIMyhT3+QwkCOugIVRBkmoWiJ me@toino.pt";
      masterIdentities = [/home/toino/.ssh/id_ed25519];
      storageMode = "local";
      localStorageDir = ./nixos;
    };

    secrets = {
      mopidy-google-client-id.rekeyFile = ./mopidy_google_client_id.age;
      mopidy-google-client-secret.rekeyFile = ./mopidy_google_client_secret.age;

      vdirsyncer-google-client-id.rekeyFile = ./vdirsyncer_google_client_id.age;
      vdirsyncer-google-client-secret.rekeyFile = ./vdirsyncer_google_client_secret.age;
    };
  };
}
