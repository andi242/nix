{ home-manager, lib, services, pkgs, config, ...} :
{
  nixpkgs.config.allowUnfree = true;
  
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  # services.xserver.enable = true;
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  services.spice-webdavd.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  environment.systemPackages = with pkgs; [
    btop
    kitty
    libnotify
    jq
    wofi
    waybar
    dunst
    swww
    ghostty
    dolphin
    distrobox
  ];
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

  };

}
