{ inputs, config, pkgs, lib, ... }:
let
  configFile = ./starship.toml;
in
{
  home.packages = with pkgs; [
    starship
  ];
  programs.starship = {
    enable = true;
    settings = lib.importTOML configFile;
  };
}
