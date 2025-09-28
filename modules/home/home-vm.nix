{ pkgs, inputs, config, pkgs-unstable, ... }:
{
  imports = [
    ./home.nix # standard home-manager settings
  ];

  userconf = {
    obs.enable = true;
    gnomesettings.enable = false;
    zellij.enable = false;
    kitty.enable = false;
    ghostty.enable = true;
    userPkgs = with pkgs; [
    ];
  };
}
