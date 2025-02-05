{ lib, config, pkgs, home,... }:
{
  imports = [
    # ./finalscript.nix
  ];

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
        # enabled-extensions=[
        # 'blur-my-shell@aunetx', 
        # 'system-monitor@gnome-shell-extensions.gcampax.github.com', 
        # 'dash-to-dock@micxgx.gmail.com', 
        # 'forge@jmmaranan.com', 
        # 'space-bar@luchrioh', 
        # 'tweaks-system-menu@extensions.gnome-shell.fifi.org', 
        # 'launch-new-instance@gnome-shell-extensions.gcampax.github.com', 
        # 'user-theme@gnome-shell-extensions.gcampax.github.com',
        # 'native-window-placement@gnome-shell-extensions.gcampax.github.com',
        # 'status-icons@gnome-shell-extensions.gcampax.github.com']
      ];
    };
  };
}
