{ inputs, config, lib, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [ "amdgpu.ppfeaturemask=0xfffd7fff" ]; # lact fan ctrl
  };
  # boot.kernelPackages = pkgs.linuxPackages_6_15; # 6.x kernel
  # boot.kernelPackages = pkgs.linuxPackages_latest; # latest kernel
  # boot.kernelPackages = pkgs.linuxPackages_zen; # latest kernel
  boot.kernelPackages = pkgs.linuxPackages_lqx; # latest kernel
  # would work, but build errors...
  # boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_zen.override {
  #   argsOverride = {
  #     version = "6.16";
  #     sha256 = "1ckysnshlrhfycz0yppna6jrnvgc9k49wr5srvl15wj1hck84p7d";
  #   };
  # });
  systemd.settings.Manager = {
    DefaultTimeoutStopSec = "30s";
  };
  networking = {
    networkmanager.enable = false;
    hostName = "nixos-pc";
    enableIPv6 = false;
    wireless.enable = false;
    usePredictableInterfaceNames = false;
    firewall = {
      enable = true;
      logRefusedConnections = false;
    };
  };

  time.timeZone = "Europe/Berlin";

  security.rtkit.enable = true;

  system.stateVersion = "24.11";
}
