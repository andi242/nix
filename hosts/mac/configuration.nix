{ inputs, config, lib, pkgs, ... }:
let
  mbp_audio = config.boot.kernelPackages.callPackage ./snd-kernel-git.nix { };
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
        #fontSize = 24;
        #font = "${pkgs.grub}/share/grub/unicode.pf2";
      };
    };
    kernelPackages = pkgs.linuxPackages_6_12; # 6.12 kernel
    extraModulePackages = [ mbp_audio ];
  };
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=40s
  '';
  networking = {
    hostName = "nixos-mac";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      logRefusedConnections = false;
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
