{ pkgs, ... }:
{
  imports = [
    ../common.nix
    ./hardware.nix
    ./configuration.nix
  ];
  sysconf = {
    fish.enable = true;
    flatpak.enable = true;
    fonts.enable = true;
    gnome.enable = true;
    nh.enable = true;
    nvim.enable = true;
    office.enable = true;
  };

  system.stateVersion = "24.11";
}
