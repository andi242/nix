{ inputs, lib, pkgs, config, ... }:
{
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;
  services.xserver = {
    enable = false;
    videoDrivers = [ "amdgpu" ];
    excludePackages = [ pkgs.xterm ];
  };
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
      wl-clipboard
      gnome-tweaks
      gnome-themes-extra
      gnome-extension-manager
      nordzy-icon-theme
      bibata-cursors
      # deja-dup
      dconf-editor
      easyeffects
      whitesur-gtk-theme
      whitesur-cursors
      whitesur-icon-theme
      pika-backup
    ];
  environment.gnome.excludePackages = with pkgs; [
    atomix
    cheese
    epiphany
    geary
    gnome-characters
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
    yelp # help viewer
    snapshot # camera
    decibels # audio player
  ];
}
