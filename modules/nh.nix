{ pkgs, config, lib, ... }:
let
  cfg = config.sysconf;
  thisOption = lib.removeSuffix ".nix" "${builtins.baseNameOf (__curPos.file)}";
in {
  options = {
    sysconf = {
      ${thisOption}.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };
  };
  config = lib.mkIf cfg.${thisOption}.enable {
    environment.systemPackages = with pkgs; [
      nh
      nvd
      nix-output-monitor
    ];
    programs.nh = {
      enable = true;
      flake = "/home/ad/gits/nix"; # sets NH_OS_FLAKE variable for you
      clean = {
        enable = true;
        extraArgs = "--keep-since 5d --keep 5";
        dates = "Mon *-*-* 00:00:00";
      };
    };
  };
}
