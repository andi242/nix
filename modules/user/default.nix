{ lib, pkgs, inputs, ... }:
{
  imports = [
    ./misc/gnome-settings.nix
    ./zsh
    ./obs
    ./misc/kitty.nix
    ./misc/librewolf.nix
  ];

  home.packages = with pkgs; [
    vesktop
    discord
    stow
    nvtopPackages.amd
    dconf2nix
    ffmpeg-full
    ytmdesktop
    streamcontroller
  ];
}
