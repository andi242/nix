{ pkgs, config, pkgs-unstable, ... }:
{
  imports = [
    ./configuration.nix
    ../../modules/system/srv.nix
    ../../modules/system/homepage
    ../../modules/system/searxng
    ../../modules/system/blocky
    # ../../modules/system/dnsmasq
    ../../modules/system/caddy
    # ../../modules/system/invid
    # ../../modules/system/psql

  ];
}
