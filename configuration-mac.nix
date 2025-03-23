{ inputs, config, lib, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  imports =
    [
      # ./modules/system/vm # install os first, then copy hardware.nix , then uncomment!
      ./modules/system/gnome
      ./modules/system/macbook
      # or with --impure
      # /etc/nixos/hardware-configuration.nix
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_6_12; # 6.12 kernel
  };
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=40s
  '';
  networking = {
    hostName = "nixos-mac";
    networkmanager.enable = true;
    firewall = {
      enable = false;
      logRefusedConnections = false;
    };
  };

  time.timeZone = "Europe/Berlin";

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  system.stateVersion = "24.11";
}
