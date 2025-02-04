{ config, pkgs, home,... }:
{
  home.packages = with pkgs; [
    dconf2nix
    gnomeExtensions.dash-to-dock
    gnomeExtensions.blur-my-shell
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
        # apps-menu.extensionUuid
      ];
    };
  };

}
