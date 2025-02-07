{ lib, services, pkgs, config, pkgs-unstable, ... }:
{
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.graphics = {
    enable = true;
  };
  services.xserver.excludePackages = [ pkgs.xterm ];
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.GTK_THEME_VARIANT = "dark";
  programs.steam.enable = true;
  # programs.steam.gamescopeSession.enable = true; #optional for scaling
  programs.gamemode.enable = true;
  # xdg.portal = {
  #   enable = true;
  #   extraPortals = with pkgs; [
  #     xdg-desktop-portal-gnome
  #     xdg-desktop-portal-gtk
  #   ];
  # };

  services.udev.packages = [ pkgs.gnome-settings-daemon ];
  environment.systemPackages =
    (with pkgs; [
      btop
      ghostty
      kitty
      jq
      distrobox
      steam
      mangohud
      lutris
      #heroic
      #bottles
      mesa
      lact
      gnome-tweaks
      gnome-themes-extra
      nordzy-icon-theme
      bibata-cursors
      wl-clipboard
    ]) ++
    (with pkgs-unstable; [
      # add
    ]);
  # lact 
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];

  environment.gnome.excludePackages = (with pkgs; [
    atomix
    cheese
    epiphany
    evince
    geary
    gnome-characters
    gnome-text-editor
    gnome-user-docs
    gnome-music
    gnome-photos
    gnome-terminal
    gnome-console
    gnome-weather
    gnome-calendar
    gnome-remote-desktop
    gnome-connections
    gnome-contacts
    gnome-maps
    gnome-tour
    hitori
    iagno
    tali
    totem
  ]);
}
