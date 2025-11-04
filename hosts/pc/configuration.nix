{ inputs, config, lib, pkgs, ... }:
{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" "acpi_enforce_resources=lax" ]; # lact fan ctrl
    extraModulePackages = [ config.boot.kernelPackages.it87 ];
    kernelModules = [ "coretemp" "it87" ];
    extraModprobeConfig = ''
      options it87 force_id=0x8628
    '';
  };
  boot.kernelPackages = pkgs.linuxPackages_lqx; # latest kernel
  systemd.settings.Manager = { DefaultTimeoutStopSec = "30s"; };
  networking = {
    networkmanager.enable = true;
    # enableIPv6 = false;
    hostName = "nixos-pc";
    wireless.enable = false;
    usePredictableInterfaceNames = false;
    firewall = {
      enable = true;
      logRefusedConnections = false;
    };
  };
  security.rtkit.enable = true;
}
