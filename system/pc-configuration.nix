{ inputs, config, lib, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports =
    [
      ./hw/pc-hardware.nix # install os first, then copy, then uncomment!
      # or with --impure
      # /etc/nixos/hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-pc";
  networking.networkmanager.enable = true;


  time.timeZone = "Europe/Berlin";

  security.rtkit.enable = true;

  nixpkgs.config = {
    allowUnfree = true; # allow unfree packages
    pulseaudio = true;
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = false;
    jack.enable = true; ### Optional, but awesome to have
  };
  # hardware.pulseaudio.enable = false;
  # https://discourse.nixos.org/t/pipewire-without-pulseaudio/58801/4
  # disable pipewire/wireplumber crap
  # nixpkgs.config.allowUnfree = true;
  # services.pipewire = {
  #   enable = lib.mkForce false;
  #   # pulse.enable = false;
  # };
  # hardware.pulseaudio.enable = true;
  # hardware.pulseaudio.support32Bit = true;
  # nixpkgs.config.pulseaudio = true;
  # # hardware.pulseaudio.extraConfig = "load-module module-combine-sink";

  system.stateVersion = "24.11";
}
