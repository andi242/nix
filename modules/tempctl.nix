{ pkgs, config, lib, ... }:
let
  cfg = config.sysconf;
  thisOption = lib.removeSuffix ".nix" "${builtins.baseNameOf (__curPos.file)}";
in {
  config = lib.mkIf cfg.${thisOption}.enable {
    environment.systemPackages = with pkgs; [
      lm_sensors
      coolercontrol.coolercontrold
    ];
    programs.coolercontrol.enable = false;
  };
}
