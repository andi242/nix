{ inputs, config, lib, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  imports =
    [
      # ./modules/system/vm # install os first, then copy, then uncomment!
      ./modules/system/gnome
      ./modules/system/pc
      # or with --impure
      # /etc/nixos/hardware-configuration.nix
      # inputs.home-manager.nixosModules.default
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

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  system.stateVersion = "24.11";
}
