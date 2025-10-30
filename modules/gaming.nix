{ pkgs, config, lib, ... }:
let
  cfg = config.sysconf;
  thisOption = lib.removeSuffix ".nix" "${builtins.baseNameOf (__curPos.file)}";
in {
  config = lib.mkIf cfg.${thisOption}.enable {
    programs = {
      steam.enable = true;
      gamemode.enable = false;
    };
    environment.systemPackages = with pkgs; [
      # furmark
      steam
      mangohud
      lutris
      winetricks
      wineWowPackages.stable
    ];
  };
}
