{ inputs, config, lib, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports =
    [
      ./hw/pc-hardware.nix # install os first, then copy, then uncomment!
      # or with --impure
      # /etc/nixos/hardware-configuration.nix
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_6_12; # 6.12 kernel
    kernelParams = [ "amdgpu.ppfeaturemask=0xfffd7fff" ]; # lact fan ctrl
  };
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=30s
  '';
  networking.hostName = "nixos-pc";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  security.rtkit.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  system.stateVersion = "24.11";
}
