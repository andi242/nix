{ config, pkgs, lib, ...} :
let
  configFile = ./starship.toml;
in 
{
  environment.systemPackages = with pkgs; [
    starship
  ];
  programs.starship = {
    enable = true;
    settings = lib.importTOML configFile;
  };
}
