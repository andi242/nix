{ inputs, config, lib, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports = [ ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [ "amdgpu.ppfeaturemask=0xfffd7fff" ]; # lact fan ctrl
  };
  # boot.kernelPackages = pkgs.linuxPackages_6_15; # 6.x kernel
  boot.kernelPackages = pkgs.linuxPackages_latest; # latest kernel
  systemd.settings.Manager = {
    DefaultTimeoutStopSec = "30s";
  };
  networking = {
    networkmanager.enable = false;
    hostName = "nixos-pc";
    enableIPv6 = false;
    wireless.enable = false;
    usePredictableInterfaceNames = false;
    firewall = {
      enable = true;
      logRefusedConnections = false;
    };
  };

  time.timeZone = "Europe/Berlin";

  security.rtkit.enable = true;

  system.stateVersion = "24.11";
}
