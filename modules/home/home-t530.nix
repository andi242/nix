{ pkgs, inputs, config, pkgs-stable, ... }:
{
  imports = [
    ./home.nix # standard home-manager settings
  ];

  userconf = {
    obs.enable = false;
    kitty.enable = false;
    zellij.enable = false;
    gnomesettings.enable = false;
    ghostty.enable = true;
    userPkgs = with pkgs; [
      (discord.override {
        withOpenASAR = true;
        # withVencord = true; # can do this here too
      })
    ];
  };
}
