{ lib, pkgs, inputs, ... }:
{
  imports = [
    ./obs
    ./zsh
    ./misc/gnome-settings.nix
    ./misc/kitty.nix
    ./misc/librewolf.nix
    ./services
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
