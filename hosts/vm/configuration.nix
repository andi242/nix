{ inputs, config, lib, pkgs, modulesPath, ... }:
let

in
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports = [
    ./nvim.nix
  ];
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
  # boot.kernelPackages = pkgs.linuxPackages_lqx; # 6.x kernel
  # boot.kernelPackages = pkgs.linuxPackages_zen; # 6.x kernel
  boot.kernelPackages = pkgs.linuxPackages_6_12; # 6.x kernel
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  # nixpkgs.config.packageOverrides =
  #   pkgs:
  #   pkgs.lib.recursiveUpdate pkgs {
  #     linuxKernel.kernels.linux_zen = pkgs.linuxKernel.kernels.linux_zen.override {
  #       extraConfig = ''
  #         HZ_1000 y
  #         HZ 1000
  #       '';
  #     };
  #   };
  nixpkgs.overlays = [
  ];
  virtualisation.vmVariant = {
    virtualisation = {
      qemu.options = [ "-device virtio-vga -audio model=hda,driver=pipewire" ];
      memorySize = 6000;
      cores = 6;
      diskSize = 20000;
      # graphics = ;
    };
  };
  environment.systemPackages = with pkgs; [
    ghostty
    fastfetch
    firefox
  ];
  environment.shells = with pkgs; [ fish ];
  users.defaultUserShell = pkgs.fish;
  programs = {
    fish = {
      enable = true;
    };
  };
  # users.extraUsers.kodi.isNormalUser = true;
  # users.users.kodi.extraGroups = [ "data" "video" "audio" "input" ];
  # services.cage.user = "kodi";
  # services.cage.program = "${pkgs.jellyfin-media-player}/bin/jellyfinmediaplayer";
  # services.cage.enable = true;

  # hardware.opengl = {
  #   enable = true;
  #   extraPackages = with pkgs; [ libva ];
  # };


  # services.xserver.desktopManager.cinnamon.enable = true;
  # services.cinnamon.apps.enable = true;
  # services.xserver.desktopManager.kodi.enable = true;

  # services.desktopManager.pantheon.enable = true;
  # services.xserver.displayManager.lightdm.enable = true;
  # services.xserver.enable = true;
  # services.getty.autologinUser = "ad";
  services.displayManager.autoLogin.user = "ad";
  services.displayManager.gdm.enable = true;
  services.displayManager.gdm.autoSuspend = false;
  # services.displayManager.gdm.banner = ''
  #   bla
  #   fasel
  #   blubb
  # '';

  services.desktopManager.gnome = {
    enable = true;
    # debug = true;
    extraGSettingsOverrides = ''
    '';
  };
  environment.variables = {
    # NIXOS_OZONE_WL = "1";
  };

  users.users.ad = {
    isNormalUser = true;
    password = "12345"; # for VM testing
    extraGroups = [ "wheel" "libvirtd" "audio" ];
    uid = 1000;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG2bj+JgXVQ+9r8UA0zpBn2cx1DhffMIJXb3tF8ClSm1 ad"
    ];
  };
  security.sudo.wheelNeedsPassword = false;


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

  services = {
    mpd.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  system.stateVersion = "25.05";
}
