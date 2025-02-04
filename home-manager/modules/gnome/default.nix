{ config, pkgs, home,... }:
{
  home.packages = with pkgs; [
    dconf2nix
    vimix-gtk-themes
    vimix-icon-theme
    bibata-cursors
    gnomeExtensions.dash-to-dock
    gnomeExtensions.blur-my-shell
    gnomeExtensions.forge
    gnomeExtensions.space-bar
    gnomeExtensions.tweaks-in-system-menu
  ];
  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        blur-my-shell.extensionUuid
        system-monitor.extensionUuid
        dash-to-dock.extensionUuid
        forge.extensionUuid
        space-bar.extensionUuid
        tweaks-in-system-menu.extensionUuid
      ];
    };
  };

}
