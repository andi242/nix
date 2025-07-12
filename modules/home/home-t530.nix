{ pkgs, inputs, config, pkgs-stable, ... }:
{
  imports = [
    ./home.nix # standard home-manager settings
  ];

  userconf = {
    obs.enable = false;
    zellij.enable = false;
    userPkgs = with pkgs; [
      (discord.override {
        withOpenASAR = true;
        # withVencord = true; # can do this here too
      })
    ];
  };
}
