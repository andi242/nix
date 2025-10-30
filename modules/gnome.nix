{ pkgs, config, lib, ... }:
let
  cfg = config.sysconf;
  thisOption = lib.removeSuffix ".nix" "${builtins.baseNameOf (__curPos.file)}";
  # this transforms the filename.nix to filename so we can use it as config.sysconf.filename.enable = true;
in {
  config = lib.mkIf cfg.${thisOption}.enable {
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gnome xdg-desktop-portal-gtk ];
    };
    services.desktopManager.gnome.enable = true;
    services.displayManager.gdm.enable = true;
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [ vulkan-tools vulkan-loader mesa ];
    };
    services.udev.packages = [ pkgs.gnome-settings-daemon ];
    environment.systemPackages = with pkgs; [
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
      dconf2nix
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
  };
}
