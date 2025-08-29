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
    ./shell
    ./ghostty
    ./misc/gnome-settings.nix
    ./misc/kitty.nix
    ./misc/librewolf.nix
    ./services
  ];

  config = {
    home.packages = with pkgs; [
      dconf2nix
      ffmpeg-full
      starship
      lazygit
    ] ++ cfg.userPkgs;
  };
}
