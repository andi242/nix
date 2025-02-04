{ lib, services, pkgs, config, pkgs-unstable, ...} :
{
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  # services.xserver.enable = true;
  # services.qemuGuest.enable = true;
  # services.spice-vdagentd.enable = true;
  # services.spice-webdavd.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  environment.systemPackages =
    ( with pkgs; [
    btop
    kitty
    libnotify
    jq
    wofi
    waybar
    dunst
    swww
    ghostty
    xfce.thunar
    distrobox
    mesa
    hyprland
    # greetd.regreet
    ]) ++
    ( with pkgs-unstable; [
    ]);

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };
  programs = {
    hyprland = {
      enable = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
    };
    waybar.enable = true;
    xwayland.enable = true;
    # regreet = {
    #   enable = true;
    #   settings.GTK = lib.mkForce {
    #     application_prefer_dark_theme = true;
    #     font_name = "GeistMono 16";
    #   };
    # };
  };
  # allow greetd to save info
  # systemd.tmpfiles.rules = [
  #   "d /var/log/regreet 0755 greeter greeter - -"
  #   "d /var/cache/regreet 0755 greeter greeter - -"
  # ];
}
