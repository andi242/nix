{ lib, services, pkgs, config, pkgs-unstable, ...} :
{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  programs.steam.enable = true;

  services.udev.packages = [ pkgs.gnome-settings-daemon ];
  environment.systemPackages =
    ( with pkgs; [
      btop
      ghostty
      kitty
      jq
      distrobox
      steam
      mesa
      gnome-tweaks
    ]) ++
    ( with pkgs-unstable; [
      # add
    ]);
  services.xserver.excludePackages = [ pkgs.xterm ];
  environment.gnome.excludePackages = (with pkgs; [
    atomix # puzzle game
    cheese # webcam tool
    epiphany # web browser
    evince # document viewer
    geary # email reader
    gedit # text editor
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
    hitori # sudoku game
    iagno # go game
    tali # poker game
    totem # video player
  ]);
}
