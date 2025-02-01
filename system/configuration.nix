{ inputs, config, lib, pkgs, ... }:

{ 
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports =
    [ 
      ./hardware-configuration.nix
      ./mounts.nix # do when VM
      # inputs.home-manager.nixosModules.home-manager
    ];
  
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

  users.users.ad = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    uid = 1000;
    # packages = with pkgs; [
    # ];
  };
  # home-manager = {
  #   extraSpecialArgs = { inherit inputs; };
  #   users = {
  #     ad = import ./home-manager/home.nix;
  #   };
  # };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    unzip
    zsh
    home-manager
  ];
  environment.shells = with pkgs; [ zsh ];
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  system.stateVersion = "24.11"; 
}

