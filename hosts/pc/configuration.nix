{ inputs, config, lib, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" "acpi_enforce_resources=lax" ]; # lact fan ctrl
    extraModulePackages = [ config.boot.kernelPackages.it87 ];
    kernelModules = [ "coretemp" "it87" ];
    extraModprobeConfig = ''
      options it87 force_id=0x8628
    '';
  };
  # boot.kernelPackages = pkgs.linuxPackages_zen; # latest kernel
  boot.kernelPackages = pkgs.linuxPackages_lqx; # latest kernel
  # boot.kernelPackages = pkgs.linuxPackages_6_16; # 6.x kernel
  # boot.kernelPackages = pkgs.linuxPackages_latest; # latest kernel
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
    networkmanager.enable = true;
    # enableIPv6 = false;
    hostName = "nixos-pc";
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
