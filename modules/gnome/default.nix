{ inputs, lib, pkgs, config, ... }:
{
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

	hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      vulkan-tools
      vulkan-loader
      mesa
    ];
  };
  imports = [ ];

  services.udev.packages = [ pkgs.gnome-settings-daemon ];

  environment.systemPackages =
    with pkgs; [
      bibata-cursors
      dconf-editor
      easyeffects
      fluent-icon-theme
      gnome-extension-manager
      gnome-themes-extra
      gnome-tweaks
      nordzy-icon-theme
      pika-backup
      wl-clipboard
    ];
  environment.gnome.excludePackages = with pkgs; [
    # decibels # audio player
    atomix
    cheese
    epiphany
    geary
    gnome-characters
    gnome-connections
    gnome-console
    gnome-contacts
    gnome-maps
    gnome-music
    gnome-photos
    gnome-remote-desktop
    gnome-terminal
    gnome-tour
    gnome-user-docs
    gnome-weather
    hitori
    iagno
    snapshot # camera
    tali
    totem
    yelp # help viewer
  ];
}
