{ pkgs, config, lib, ... }:
let
  cfg = config.sysconf;
  thisOption = lib.removeSuffix ".nix" "${builtins.baseNameOf (__curPos.file)}";
in {
  options.sysconf = {
    ${thisOption}.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
  config = lib.mkIf cfg.${thisOption}.enable {
    programs = {
      steam.enable = true;
      gamemode.enable = true;
    };
    environment.systemPackages = with pkgs; [
      furmark
      steam
      mangohud
      lutris
      winetricks
      wineWowPackages.stable
    ];
  };
}
