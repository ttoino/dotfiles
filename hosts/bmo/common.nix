{ ... }:
{
  age.rekey = {
    hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL8sBfh3Y90/+Za1gdqVIMyhT3+QwkCOugIVRBkmoWiJ me@toino.pt";
    masterIdentities = [ /home/toino/.ssh/id_ed25519 ];
    localStorageDir = ./secrets;
  };
}
