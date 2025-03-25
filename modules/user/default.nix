{ lib, pkgs, inputs, config, ... }:
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
    home-manager
    nh # nix helper
    nix-output-monitor # for nh
    nvd # for nh
    duf # du in nice
  ];
}
