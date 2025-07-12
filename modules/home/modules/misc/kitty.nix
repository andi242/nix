{ pkgs, config, lib, ... }:
let
  cfg = config.userconf;
in
{
  options = {
    userconf = {
      kitty.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };
  config = lib.mkIf cfg.kitty.enable
    {
      programs.kitty = {
        enable = true;
        settings = {
          font_size = 15;
          background_opacity = 0.90;
          background_blur = 1;
          include = "theme.conf";
          confirm_os_window_close = "0";
        };
      };
      # download current theme
      # https://github.com/catppuccin/kitty/blob/main/themes/macchiato.conf
      xdg.configFile = {
        "kitty" = {
          enable = true;
          source = ./kitty-theme.conf;
          target = "kitty/theme.conf";
        };
      };
    };
}
