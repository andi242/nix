{ inputs, config, lib, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  imports =
    [
      inputs.sops-nix.nixosModules.sops
    ];

  sops = {
    defaultSopsFile = ../../secrets/pc.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/ad/.config/sops/age/keys.txt";
  };
  sops.secrets.wifi_file = {
    owner = config.users.users.ad.name;
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [ "amdgpu.ppfeaturemask=0xfffd7fff" ]; # lact fan ctrl
  };
  boot.kernelPackages = pkgs.linuxPackages_6_13; # 6.x kernel
  # boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_6_12.override {
  #   argsOverride = rec {
  #     src = pkgs.fetchurl {
  #       url = "mirror://kernel/linux/kernel/v6.x/linux-${version}.tar.xz";
  #       sha256 = "sha256-1zvwV77ARDSxadG2FkGTb30Ml865I6KB8y413U3MZTE=";
  #     };
  #     version = "6.12.19";
  #     modDirVersion = "6.12.19";
  #   };
  # });
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=30s
  '';
  networking = {
    hostName = "nixos-pc";
    networkmanager.enable = true;
    firewall = {
      enable = true;
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
