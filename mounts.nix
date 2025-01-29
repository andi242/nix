{ config, pkgs, ... } : 
{
  fileSystems."/data" = {
    fsType = "virtiofs";
    device = "data";
    options = ["rw" "nofail"];
  };
}
