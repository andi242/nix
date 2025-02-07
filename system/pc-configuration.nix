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

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Berlin";
  
  security.rtkit.enable = true;

  # disable pipewire/wireplumber crap
  services.pipewire = {
    enable = lib.mkForce false;
    # pulse.enable = false;
  };
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  nixpkgs.config.pulseaudio = true;
  # hardware.pulseaudio.extraConfig = "load-module module-combine-sink";

  system.stateVersion = "24.11";
}

