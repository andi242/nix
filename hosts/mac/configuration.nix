{ inputs, config, lib, pkgs, ... }:
let
  mbp_audio = config.boot.kernelPackages.callPackage ./snd-kernel-git.nix { };
  wireguard = config.boot.kernelPackages.wireguard;
in
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  imports = [ ];

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
      grub = {
        efiSupport = true;
        enable = true;
        device = "nodev";
      };
    };
    kernelPackages = pkgs.linuxPackages_6_12; # 6.12 kernel
    extraModulePackages = [ mbp_audio wireguard ];
  };
  boot.loader.grub.theme = pkgs.stdenv.mkDerivation {
    pname = "distro-grub-themes";
    version = "3.1";
    src = pkgs.fetchFromGitHub {
      owner = "AdisonCavani";
      repo = "distro-grub-themes";
      rev = "v3.1";
      hash = "sha256-ZcoGbbOMDDwjLhsvs77C7G7vINQnprdfI37a9ccrmPs=";
    };
    installPhase = "cp -r customize/nixos $out";
  };

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=40s
  '';
  networking = {
    hostName = "nixos-mac";
    enableIPv6 = false;
    usePredictableInterfaceNames = false;
    networkmanager.enable = true;
    firewall = {
      enable = true;
      checkReversePath = false;
      logReversePathDrops = true;
      logRefusedConnections = true;
    };
  };

  security.rtkit.enable = true;
  services.openssh.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  system.stateVersion = "24.11";
}
