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
  boot.initrd.checkJournalingFS = false;

  networking.hostName = "nixos-pc";
  networking.networkmanager.enable = true;

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Berlin";

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # user config
  users.users.ad = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd"];
    uid = 1000;
  };
  security.sudo.extraRules = [
    { groups = [ "wheel" ]; commands = [ {command = "ALL" ; options = [ "NOPASSWD" ]; } ]; }
  ];

  system.stateVersion = "24.11"; 
}

