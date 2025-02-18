{ lib, config, pkgs, home, ... }:
{
  imports = [
    ./theme-tweaks.nix
    ../misc/kitty.nix
  ];

  home.packages = with pkgs; [
    discord
    stow
    nvtopPackages.amd
    dconf2nix
    # rclone
    # rclone-browser
    gnomeExtensions.dash-to-dock
    gnomeExtensions.blur-my-shell
    gnomeExtensions.forge
    gnomeExtensions.space-bar
    gnomeExtensions.tweaks-in-system-menu
    gnomeExtensions.appindicator
    gnomeExtensions.quick-settings-audio-panel
    gnomeExtensions.clipboard-history
    gnomeExtensions.just-perfection
    gnomeExtensions.gamemode-shell-extension
  ];
  xdg.desktopEntries = {
    zellij = {
      name = "Zellij";
      exec = "kitty zellij";
      terminal = false;
      categories = [ "Application" ];
      icon = "/home/ad/.local/share/applications/zellij-icon.png";
      actions = {
        kitty = {
          exec = "kitty";
        };
      };
    };
  };
  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          blur-my-shell.extensionUuid
          system-monitor.extensionUuid
          dash-to-dock.extensionUuid
          forge.extensionUuid
          space-bar.extensionUuid
          tweaks-in-system-menu.extensionUuid
          clipboard-history.extensionUuid
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          # launch-new-instance.extensionUuid
          status-icons.extensionUuid
          quick-settings-audio-panel.extensionUuid
          launch-new-instance.extensionUuid
          "just-perfection-desktop@just-perfection"
          "gamemodeshellextension@trsnaqe.com"
        ];
      };
      "org/gnome/desktop/input-sources" = {
        show-all-sources = true;
        sources = [ (lib.hm.gvariant.mkTuple [ "xkb" "eu" ]) ];
        xkb-options = "";
      };
      "org/gnome/shell/extensions/just-perfection" = {
        clock-menu = true;
        clock-menu-position = 1;
        clock-menu-position-offset = 6;
      };
      "org/gnome/desktop/wm/keybindings" = {
        close = [ "<Super>q" ];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super>Return";
        command = "kitty zellij";
        name = "Open Terminal";
      };
      "org/gnome/shell/extensions/system-monitor" = {
        show-download = false;
        show-swap = false;
        show-upload = false;
      };
      "org/gnome/shell/extensions/user-theme" = {
        name = "theme-tweaks";
      };
      "org/gnome/mutter" = {
        dynamic-workspaces = true;
        workspaces-only-on-primary = true;
      };
      "org/gnome/desktop/interface" = {
        accent-color = "green";
        clock-show-weekday = true;
        color-scheme = "prefer-dark";
        cursor-theme = "Bibata-Modern-Classic";
        document-font-name = "GeistMono Nerd Font Propo 12";
        enable-hot-corners = true;
        font-antialiasing = "rgba";
        font-name = "GeistMono Nerd Font Propo 10";
        gtk-theme = "Adwaita-dark";
        icon-theme = "Nordzy-dark";
        monospace-font-name = "GeistMono Nerd Font Propo Medium 12";
        toolkit-accessibility = false;
      };
      "shell/extensions/dash-to-dock" = {
        always-center-icons = true;
        background-opacity = 0.8;
        click-action = "cycle-windows";
        dash-max-icon-size = 48;
        dock-position = "BOTTOM";
        extend-height = false;
        height-fraction = 0.9;
        hot-keys = false;
        icon-size-fixed = false;
        isolate-monitors = true;
        isolate-workspaces = false;
        middle-click-action = "launch";
        multi-monitor = true;
        # preferred-monitor = -2;
        # preferred-monitor-by-connector = "DP-3";
        preview-size-scale = 8.0e-2;
        scroll-action = "switch-workspace";
        shift-click-action = "minimize";
        shift-middle-click-action = "launch";
        show-favorites = true;
        show-mounts = false;
        show-mounts-only-mounted = true;
        show-running = true;
      };
      "org/gnome/desktop/wm/preferences" = {
        action-double-click-titlebar = "toggle-maximize";
        auto-raise = true;
        button-layout = "appmenu:minimize,maximize,close";
        focus-mode = "mouse";
        resize-with-right-button = true;
        workspace-names = [ ];
      };
      "org/gnome/desktop/background" = {
        color-shading-type = "solid";
        picture-options = "zoom";
        picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/morphogenesis-l.svg";
        picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/morphogenesis-d.svg";
        primary-color = "#e18477";
        secondary-color = "#000000";
      };
    };
  };
}
