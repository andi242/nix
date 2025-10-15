{ pkgs, inputs, config, pkgs-stable, ... }:
{
  imports = [
    ./home.nix # standard home-manager settings
  ];

  userconf = {
    obs.enable = false;
    zellij.enable = false;
    kitty.enable = false;
    ghostty.enable = true;
    userPkgs = with pkgs; [
      nvtopPackages.amd
      # streamcontroller # nix pkg is broken due to python dep, use flatpak
      # (discord.override {
      #   withOpenASAR = true;
      #   # withVencord = true; # can do this here too
      # })
    ];
  };
}
