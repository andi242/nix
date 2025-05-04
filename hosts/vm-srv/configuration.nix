{ inputs, config, lib, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  imports = [ ];
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
  boot.kernelPackages = pkgs.linuxPackages_6_13; # 6.x kernel

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=30s
  '';
  networking = {
    hostName = "nixos-srv";
    # nameservers = [ "192.168.1.11" ];
    # defaultGateway = "192.168.1.1";
    enableIPv6 = false;
    wireless.enable = false;
    # interfaces.enp5s0 = {
    #   useDHCP = false;
    #   ipv4.addresses = [{
    #     address = "192.168.1.48";
    #     prefixLength = 24;
    #   }];
    # };
    networkmanager.enable = true;
    firewall = {
      enable = true;
      logRefusedConnections = false;
    };
  };

  security.rtkit.enable = true;

  services = {
    openssh.enable = true;
    pipewire = {
      enable = false;
    };
  };
  system.stateVersion = "24.11";
}
