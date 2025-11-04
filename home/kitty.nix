{ pkgs, config, lib, ... }:
let
  cfg = config.userconf;
  thisOption = lib.removeSuffix ".nix" "${builtins.baseNameOf (__curPos.file)}";
in {
  config = lib.mkIf cfg.${thisOption}.enable {
    programs.kitty = {
      enable = true;
      settings = {
        font_size = 15;
        background_opacity = 0.9;
        background_blur = 1;
        include = "${pkgs.kitty-themes}/share/kitty-themes/themes/Catppuccin-Macchiato.conf";
          # "theme.conf";
        # theme = "Catppuccin-Macchiato";
        confirm_os_window_close = "0";
      };
    };
  };
}
