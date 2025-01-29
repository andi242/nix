{ config, lib, pkgs, ... }:

{ 
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports =
    [ 
      ./hardware-configuration.nix
      ./mounts.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.checkJournalingFS = false;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ad = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  # programs.firefox.enable = true;
  # programs.hyprland.enable = true;

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    neovim 
    git
    wget
    curl
    kitty
  ];
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;
  
  system.stateVersion = "24.11"; # Did you read the comment?

}

