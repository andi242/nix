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
  # programs = {
  #   steam.enable = true;
  #   # programs.steam.gamescopeSession.enable = true; #optional for scaling
  #   gamemode.enable = true;
  #   evolution.enable = true;
  # };

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
      easyeffects
      helvum
    ]) ++
    (with pkgs-unstable;
    [
      # add
    ]);
  # for 0.7.0:
  # systemd.services.lactd = {
  #   description = "AMDGPU Control Daemon";
  #   enable = true;
  #   serviceConfig = {
  #     # this path because we don't use pkgs.lact
  #     ExecStart = "/run/current-system/sw/bin/lact daemon";
  #   };
  #   wantedBy = [ "multi-user.target" ];
  # };
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
