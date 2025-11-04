{ pkgs, config, lib, osConfig, ... }:
let
  cfg = config.userconf;
  thisOption = "gnome-settings";
  multi-monitors-add-on = pkgs.callPackage ./multimonitor.nix { };
in {
  options.userconf.${thisOption} = {
    dconf-settings.enable = lib.mkOption {
      type = lib.types.bool;
      default = osConfig.sysconf.gnome.enable;
    };
  };
  config = lib.mkIf cfg.${thisOption}.enable {
    # TODO: rework the thing
    home.packages = with pkgs; [
      gnomeExtensions.dash-to-dock
      gnomeExtensions.appindicator
      gnomeExtensions.streamcontroller-integration
      gnomeExtensions.tiling-shell
      multi-monitors-add-on
      (gnomeExtensions.another-window-session-manager.overrideAttrs (oldAttrs: {
        version = "50";
        # direct dl link
        # https://extensions.gnome.org/extension-data/another-window-session-managergmail.com.v50.shell-extension.zip
        src = fetchzip {
          url = "https://extensions.gnome.org/extension-data/another-window-session-managergmail.com.v50.shell-extension.zip";
          hash = "sha256-SdBfs/yXALVQklCmb4K7hZfUkCP2uzIp9Gg40fp/DJQ=";
          stripRoot = false;
        };
      }))
      # (gnomeExtensions.arcmenu.overrideAttrs (oldAttrs: {
      #   # https://gitlab.com/arcmenu/ArcMenu
      #   version = "67.1";
      #   src = pkgs.fetchFromGitLab {
      #     owner = "arcmenu";
      #     repo = "ArcMenu";
      #     rev = "v67.1";
      #     hash = "sha256-AauFc27zHvxc6hGFwP5LuyjmnYQ9DWysKiWhEheancI=";
      #   };
      #   patches = [ (replaceVars ./arcmenu-fix.patch { gmenu_path = "${gnome-menus}/lib/girepository-1.0"; }) ];
      # }))
    ];
    dconf = {
      enable = cfg.${thisOption}.dconf-settings.enable;
      settings = {
        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = with pkgs.gnomeExtensions; [
            "appindicatorsupport@rgcjonas.gmail.com"
            "tilingshell@ferrarodomenico.com"
            "multi-monitors-add-on@spin83"
            "another-window-session-manager@gmail.com"
            "dash-to-dock@micxgx.gmail.com"
            streamcontroller-integration.extensionUuid
          ];
        };

        "org/gnome/desktop/input-sources" = {
          show-all-sources = true;
          sources = [ (lib.hm.gvariant.mkTuple [ "xkb" "eu" ]) ];
          xkb-options = "";
        };
        "org/gnome/desktop/wm/keybindings" = { close = [ "<Super>q" ]; };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          binding = "<Super>Return";
          command = "ghostty";
          name = "Open Terminal";
        };
        "org/gnome/desktop/wm/preferences" = {
          action-double-click-titlebar = "toggle-maximize";
          auto-raise = true;
          button-layout = "appmenu:minimize,maximize,close";
          focus-mode = "mouse";
          resize-with-right-button = true;
          workspace-names = [ ];
        };
      };
    };
  };
}
