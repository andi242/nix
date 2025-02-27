{ inputs, config, lib, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports =
    [
      ./hw/macbook-hardware.nix
      ./sys
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.checkJournalingFS = false;

  networking.hostName = "nixos-mac";
  networking.networkmanager.enable = true;

  # nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Berlin";

  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };
  nixpkgs.config = {
    allowUnfree = true;
    pulseaudio = true;
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true; ### Optional, but awesome to have
  };
  hardware.pulseaudio.enable = false;

  users.users.ad = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    uid = 1000;
  };

  system.stateVersion = "24.11";
}
