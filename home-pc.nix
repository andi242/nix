{ pkgs, inputs, config, ... }:
{
  imports = [
    ./home.nix # standard home-manager settings
  ];

  userconf = {
    obs.enable = true;
    userPkgs = with pkgs; [
      nvtopPackages.amd
      ytmdesktop
      streamcontroller
      discord
    ];
  };
}
