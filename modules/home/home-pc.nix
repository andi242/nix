{ pkgs, inputs, config, pkgs-unstable, ... }:
{
  imports = [
    ./home.nix # standard home-manager settings
  ];

  userconf = {
    obs.enable = true;
    zellij.enable = true;
    userPkgs = with pkgs; [
      nvtopPackages.amd
      # ytmdesktop
      streamcontroller
      (discord.override {
        withOpenASAR = true;
        # withVencord = true; # can do this here too
      })
    ];
  };
}
