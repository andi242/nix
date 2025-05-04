{ pkgs, config, pkgs-unstable, ... }:
{
  imports = [
    ./configuration.nix
    # https://github.com/NixOS/nixpkgs/issues/61617#issuecomment-623934193
    # ../modules/dnsmasq

    # ../modules/dhcpd
    # ../modules/blocky?
    # ../modules/k3s?
    # ../modules/paperless?
    # ../modules/homepage?
  ];
}
