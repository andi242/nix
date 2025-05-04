{
  imports = [
    ./hardware.nix
    ./configuration.nix
    ../../modules/system/srv.nix
    ../../modules/system/homepage
    ../../modules/system/searxng
    ../../modules/system/blocky
    ../../modules/system/dnsmasq
  ];
}
