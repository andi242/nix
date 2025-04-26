{ pkgs, inputs, config, pkgs-unstable, ... }:
{
  imports = [
    ./home.nix # standard home-manager settings
  ];

  userconf = {
    obs.enable = false;
    zellij.enable = true;
    userPkgs = with pkgs; [
    ];
  };
}
