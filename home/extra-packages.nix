{ pkgs, config, lib, ... }:
let
  cfg = config.userconf;
  thisOption = lib.removeSuffix ".nix" "${builtins.baseNameOf (__curPos.file)}";
in {
  config = lib.mkIf cfg.${thisOption}.enable {
    home.packages = with pkgs;
      [
        # discord # flat pakking for now
        sonixd # jellyfin audio player
      ];
  };

}
