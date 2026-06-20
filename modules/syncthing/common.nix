{ ... }:
{
  services.syncthing = {
    overrideDevices = true;
    overrideFolders = true;
    guiAddress = "127.0.0.1:8384";
    settings.options = {
      listenAddresses = [ "tcp://0.0.0.0:22000" ];
      globalAnnounceEnabled = false;
      localAnnounceEnabled = false;
      relaysEnabled = false;
      urAccepted = -1;
    };
  };
}
