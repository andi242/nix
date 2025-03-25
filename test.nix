{ config, lib, ... }:
let
  cfg = config.userconf;
in
# https://nixos.wiki/wiki/NixOS_modules
{
  options = {
    userconf = {
      text = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };
  };
  config = lib.mkIf cfg.text {
    home.sessionVariables = {
      BLA = "blubb";
    };
    home.file.".config/test.txt".text = "blafasel";
  };
}
