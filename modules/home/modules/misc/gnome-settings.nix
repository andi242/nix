{ lib, pkgs, inputs, ... }:
{

  home.file = {
    ".themes/theme-tweaks/gnome-shell/gnome-shell.css".text = ''
       #panel {
        font-size: 20px;
      }
    '';
  };
  home.packages = with pkgs; [
    gnomeExtensions.dash-to-panel
    gnomeExtensions.blur-my-shell
    gnomeExtensions.forge
    gnomeExtensions.user-themes
    gnomeExtensions.space-bar
    gnomeExtensions.tweaks-in-system-menu
    gnomeExtensions.appindicator
    gnomeExtensions.quick-settings-audio-panel
    gnomeExtensions.clipboard-history
    gnomeExtensions.gamemode-shell-extension
    gnomeExtensions.vitals
    gnomeExtensions.streamcontroller-integration
    # gnomeExtensions.another-window-session-manager # still v49
    # gnomeExtensions.just-perfection
    # gnomeExtensions.dash-to-dock
  ];
  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          # system-monitor.extensionUuid
          # dash-to-dock.extensionUuid
          # "just-perfection-desktop@just-perfection"
          # forge.extensionUuid
          # launch-new-instance.extensionUuid
          blur-my-shell.extensionUuid
          "dash-to-panel@jderose9.github.com"
          space-bar.extensionUuid
          tweaks-in-system-menu.extensionUuid
          clipboard-history.extensionUuid
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          status-icons.extensionUuid
          quick-settings-audio-panel.extensionUuid
          launch-new-instance.extensionUuid
          streamcontroller-integration.extensionUuid
          "multi-monitors-add-on@spin83"
          "gamemodeshellextension@trsnaqe.com"
          "Vitals@CoreCoding.com"
          "appindicatorsupport@rgcjonas.gmail.com"
          "another-window-session-manager@gmail.com"
        ];
      };
      "org/gnome/shell/extensions/appindicator" = {
        icon-size = 24;
        legacy-tray-enabled = true;
        tray-pos = "right";
      };
      "org/gnome/shell/extensions/vitals" = {
        alphabetize = false;
        fixed-widths = true;
        hide-icons = false;
        hide-zeros = false;
        hot-sensors = [ "_memory_usage_" "_temperature_k10temp_tctl_" "_processor_usage_" ];
        icon-style = 1;
        include-static-gpu-info = true;
        menu-centered = false;
        position-in-panel = 2;
        show-fan = false;
        show-gpu = true;
        show-network = false;
        show-processor = true;
        show-storage = false;
        show-system = true;
        show-temperature = true;
        show-voltage = false;
        storage-measurement = 1;
        storage-path = "/";
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
        # command = "kitty zellij";
        command = "ghostty";
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
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
        mic-mute = [ "F12" ];
        volume-step = 2;
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
