{ pkgs, inputs, config, ... }:
{
  imports = [
    ./home.nix # standard home-manager settings
  ];
  userconf = {
    obs.enable = false;
    zellij.enable = false;
    kitty.enable = true;
    ghostty.enable = true;
  };
}
