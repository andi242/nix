{ inputs, config, lib, pkgs, ... }:
let
  # gvfs = pkgs.gvfs.override { googleSupport = true; gnomeSupport = true; };
in
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # nixpkgs.config.allowUnfree = true;
  imports = [ ];
  environment.systemPackages = [
    # gvfs
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
  # boot.kernelPackages = pkgs.linuxPackages_lqx; # 6.x kernel
  boot.kernelPackages = pkgs.linuxPackages_6_12; # 6.x kernel
  virtualisation.vmVariant = {
    virtualisation = {
      qemu.options = [ "-device virtio-vga" ];
      memorySize = 6000;
      cores = 6;
      diskSize = 20000;
      # graphics = ;
    };
  };

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome = {
    enable = true;
    debug = true;
    extraGSettingsOverrides = ''

    '';
  };
  environment.variables = {
    GVFS_DEBUG = "all";
    GVFS_SMB_DEBUG = 10;
  };

  users.users.ad = {
    isNormalUser = true;
    password = "12345";
    extraGroups = [ "wheel" "libvirtd" "audio" ];
    uid = 1000;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG2bj+JgXVQ+9r8UA0zpBn2cx1DhffMIJXb3tF8ClSm1 ad"
    ];
  };
  security.sudo.wheelNeedsPassword = false;
  # pkgs.gvfs.override = {googleSupport = true;};
  nixpkgs.overlays = [
    (final: prev: {
      gnome = prev.gnome.overrideScope (gfinal: gprev: {
        gvfs = gprev.gvfs.override {
          googleSupport = true;
          gnomeSupport = true;
        };
      });
    })
    # (final: prev: {
    #   gvfs = prev.gvfs.override {
    #     googleSupport = true;
    #     gnomeSupport = true;
    #   };
    # })

    # (final: prev: {
    #   gnome-online-accounts = prev.gnome-online-accounts.overrideAttrs (old: {
    #     src = prev.fetchurl {
    #       url = "mirror://gnome/sources/gnome-online-accounts/3.54.3/gnome-online-accounts-3.54.3.tar.xz";
    #       hash = "sha256-vPZV3R3cIrwleTtoQNoZ9crXugtyJ/+WntnCUvA2qsU=";
    #     };
    #   });
    # })
  ];

  systemd.settings.Manager = {
    DefaultTimeoutStopSec = "30s";
  };
  networking = {
    hostName = "nixos-vm";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      logRefusedConnections = false;
    };
  };

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  system.stateVersion = "25.05";
}
