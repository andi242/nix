{ lib, config, pkgs, home,... }:
{
  imports = [
    # ./finalscript.nix
  ];

  home.packages = with pkgs; [
    dconf2nix
    gnomeExtensions.dash-to-dock
    gnomeExtensions.blur-my-shell
    gnomeExtensions.forge
    gnomeExtensions.space-bar
    gnomeExtensions.tweaks-in-system-menu
    gnomeExtensions.appindicator
  ];

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    settings."org/gnome/desktop/input-sources" = {
        show-all-sources = true;
        sources = [ (lib.hm.gvariant.mkTuple[ "xkb" "eu" ]) ];
        xkb-options = "";
      };
    settings."org/gnome/shell/extensions/system-monitor" = {
      show-download = false;
      show-swap = false;
      show-upload = false;
    };
    settings."org/gnome/mutter" = {
      dynamic-workspaces = true;
      workspaces-only-on-primary = true;
    };
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        blur-my-shell.extensionUuid
        system-monitor.extensionUuid
        dash-to-dock.extensionUuid
        forge.extensionUuid
        space-bar.extensionUuid
        tweaks-in-system-menu.extensionUuid
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        launch-new-instance.extensionUuid
        status-icons.extensionUuid
        launch-new-instance.extensionUuid
      ];
    };
  };
}
