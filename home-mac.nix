{ pkgs, inputs, config, ... }:
{
  imports = [
    ./home.nix # standard home-manager settings
  ];

  userconf = {
    obs.enable = false;
    # userPkgs = with pkgs; [
    #   nh # nix helper
    #   nix-output-monitor # for nh
    #   nvd # for nh
    #   geist-font
    #   kitty
    #   zsh
    # ];
  };
}
