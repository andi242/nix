{ lib, pkgs, inputs, ... }:
{
  imports = [
    ./obs
    ./zsh
    ./misc/gnome-settings.nix
    ./misc/kitty.nix
    ./misc/librewolf.nix
    ./services/nix-optimize.nix
  ];

  home.packages = with pkgs; [
    discord
    nvtopPackages.amd
    dconf2nix
    ffmpeg-full
    ytmdesktop
    streamcontroller
  ];
}
