{ lib, pkgs, inputs, config, ... }:
let
  cfg = config.userconf;
in
{
  options = {
    userconf = {
      userPkgs = lib.mkOption {
        type = lib.types.listOf lib.types.package;
        default = [ ];
        example = with pkgs; [ curl wget ];
      };
    };
  };

  imports = [
    ./obs
    ./zsh
    ./misc/gnome-settings.nix
    ./misc/kitty.nix
    ./misc/librewolf.nix
    ./services
  ];

  config = {
    home.packages = with pkgs; [
      dconf2nix
      ffmpeg-full
      bat
      starship
      zsh
      lazygit
      home-manager
      nh # nix helper
      nix-output-monitor # for nh
      nvd # for nh
      duf # du in nice
    ] ++ cfg.userPkgs;
  };
}
