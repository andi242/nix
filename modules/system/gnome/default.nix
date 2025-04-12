{ inputs, lib, pkgs, config, pkgs-unstable, ... }:
{
  services.xserver = {
    enable = false;
    videoDrivers = [ "amdgpu" ];
    excludePackages = [ pkgs.xterm ];
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  imports = [ ];

  services.udev.packages = [ pkgs.gnome-settings-daemon ];

  environment.systemPackages =
    (with pkgs; [
      btop
      kitty
      jq
      gnome-tweaks
      gnome-themes-extra
      gnome-extension-manager
      nordzy-icon-theme
      bibata-cursors
      wl-clipboard
      # easyeffects
      # helvum
    ]) ++
    (with pkgs-unstable;
    [
      # add
    ]);

  environment.gnome.excludePackages = with pkgs; [
    atomix
    cheese
    epiphany
    evince
    # geary
    # gnome-calendar
    gnome-characters
    gnome-text-editor
    gnome-user-docs
    gnome-music
    gnome-photos
    gnome-terminal
    gnome-console
    gnome-weather
    gnome-remote-desktop
    gnome-connections
    gnome-contacts
    gnome-maps
    gnome-tour
    hitori
    iagno
    tali
    totem
  ];
}
