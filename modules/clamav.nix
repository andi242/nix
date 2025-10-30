{ pkgs, config, lib, ... }:
let
  cfg = config.sysconf;
  thisOption = lib.removeSuffix ".nix" "${builtins.baseNameOf (__curPos.file)}";
in {
  config = lib.mkIf cfg.${thisOption}.enable {
    services.clamav = {
      updater.enable = true;
      daemon.enable = true;
    };
    environment.systemPackages = with pkgs; [ clamav ];
  };
}
