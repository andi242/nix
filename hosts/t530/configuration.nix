{ inputs, config, lib, pkgs, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  imports = [ ];

  boot = {
    kernelPackages = pkgs.linuxPackages_6_12; # 6.12 kernel
    extraModulePackages = [ ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=40s
  '';
  networking = {
    hostName = "t530";
    enableIPv6 = false;
    usePredictableInterfaceNames = false;
    networkmanager.enable = true;
    firewall = {
      enable = true;
      checkReversePath = false;
      logReversePathDrops = true;
      logRefusedConnections = true;
    };
  };

  security.rtkit.enable = true;
  services.openssh.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  system.stateVersion = "24.11";
}
