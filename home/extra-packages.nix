{ pkgs, config, lib, ... }:
let
  cfg = config.userconf;
  thisOption = lib.removeSuffix ".nix" "${builtins.baseNameOf (__curPos.file)}";
in {
  options.userconf = {
    ${thisOption}.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };
  config = lib.mkIf cfg.${thisOption}.enable { 
    home.packages = with pkgs; [ 
      discord
      sonixd # jellyfin audio player
    ];
  };
}
