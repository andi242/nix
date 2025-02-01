{ config, pkgs, ... } : 
{
  # fileSystems."/data" = {
  #   fsType = "virtiofs";
  #   device = "data";
  #   # options = ["rw" "nofail"];
  # };
  fileSystems."/shared" = {
    fsType = "9p";
    device = "/shared";
    options = ["rw" "trans=virtio"];
  };

}
