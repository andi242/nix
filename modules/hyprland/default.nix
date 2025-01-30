{ services, pkgs, config, ...} :
{
  nixpkgs.config.allowUnfree = true;
  
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.enable = true;
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  services.spice-webdavd.enable = true;

  environment.systemPackages = with pkgs; [
    btop
    ags
    kitty
    jq
    rofi-wayland
  ];
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
