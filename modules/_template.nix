{ pkgs, config, lib, ... }:
let
  cfg = config.sysconf;
  # take the current filename, strip .nix and make it the option name
  thisOption = lib.removeSuffix ".nix" "${builtins.baseNameOf (__curPos.file)}";
in {
  options.sysconf = {
    ${thisOption}.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
  config = lib.mkIf cfg.${thisOption}.enable { };
}
