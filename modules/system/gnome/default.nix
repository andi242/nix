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
  imports = [
  ];
  programs = {
    steam.enable = true;
    # programs.steam.gamescopeSession.enable = true; #optional for scaling
    gamemode.enable = true;
    evolution.enable = true;
  };

  services.udev.packages = [ pkgs.gnome-settings-daemon ];
  # environment.sessionVariables = {
  #   NIXOS_OZONE_WL = "1";
  #   GTK_THEME_VARIANT = "dark";
  # };
  environment.systemPackages =
    (with pkgs; [
      btop
      kitty
      jq
      steam
      mangohud
      lutris
      winetricks
      wineWowPackages.stable
      # (lutris.override {
      #   extraPkgs = pkgs: [
      #     winetricks
      #     wineWowPackages.stable
      #   ];
      # })
      # heroic
      # bottles
      libcamera # wireplumber might want it
      mesa
      (callPackage ./lact.nix { })
      furmark
      gnome-tweaks
      gnome-themes-extra
      gnome-extension-manager
      nordzy-icon-theme
      bibata-cursors
      wl-clipboard
      easyeffects
    ]) ++
    (with pkgs-unstable;
    [
      # add
    ]);
  # systemd.packages = with pkgs; [ lact ];
  # systemd.services.lactd.wantedBy = [ "multi-user.target" ];
  # for 0.7.0:
  systemd.services.lactd = {
    description = "AMDGPU Control Daemon";
    enable = true;
    serviceConfig = {
      # this path because we don't use pkgs.lact
      ExecStart = "/run/current-system/sw/bin/lact daemon";
    };
    wantedBy = [ "multi-user.target" ];
  };
  # programs.corectrl.enable = true;
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
