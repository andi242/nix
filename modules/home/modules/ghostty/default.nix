{ pkgs, config, lib, ... }:
let
  cfg = config.userconf;
in
{
  options = {
    userconf = {
      ghostty.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };
  config = lib.mkIf cfg.ghostty.enable
    {
      home.packages = with pkgs; [
        ghostty
      ];
      xdg.configFile = {
        "ghostty" = {
          enable = true;
          source = ./config;
          target = "ghostty/config";
        };
      };
    };
}
