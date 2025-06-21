{ pkgs, inputs, config, pkgs-stable, ... }:
{
  imports = [
    ./home.nix # standard home-manager settings
  ];

  userconf = {
    obs.enable = true;
    zellij.enable = true;
    userPkgs = with pkgs; [
      nvtopPackages.amd
      streamcontroller
      # (streamcontroller.overrideAttrs (oldAttrs: rec {
      #   version = "1.5.0-beta.9";
      #   src = pkgs.fetchFromGitHub {
      #     repo = "StreamController";
      #     owner = "StreamController";
      #     # https://github.com/StreamController/StreamController/releases/
      #     # get hash from releases
      #     rev = "be88bad807d66c3595f19f778bf92904951919e8";
      #     hash = "sha256-CFJFq5DdK4nZnFs8EATbp1kw47p3NIGfUrwlEa0+Ogs=";
      #   };
      # }))
      (discord.override {
        withOpenASAR = true;
        # withVencord = true; # can do this here too
      })
    ];
  };
}
