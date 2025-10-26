{ pkgs, config, lib, inputs, ... }:
let
  cfg = config.userconf;
  thisOption = lib.removeSuffix ".nix" "${builtins.baseNameOf (__curPos.file)}";
  dotspath = builtins.toString inputs.nix-dotfiles;
in {
  options.userconf = {
    ${thisOption}.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
  config = lib.mkIf cfg.${thisOption}.enable {
    home.packages = with pkgs; [ ghostty ];
    xdg.configFile = {
      "ghostty" = {
        enable = true;
        source = "${dotspath}/ghostty/config";
        target = "ghostty/config";
      };
    };
  };
}
