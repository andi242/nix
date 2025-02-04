{ config, pkgs, home,... }:
{
  home.packages = with pkgs; [
    dconf2nix
  ];
  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        blur-my-shell.extensionUuid
        gsconnect.extensionUuid
        system-monitor.extensionUuid
        # apps-menu.extensionUuid
      ];
    };
  };

}
