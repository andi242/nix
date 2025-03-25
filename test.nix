{ config, pkgs, lib, ... }:
let
  cfg = config.mymodule;
in
{
  options = {
    mymodule = {
      text = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };
  };
  config = lib.mkIf cfg.text {
    environment.sessionVariables = {
      BLA = "blubb";
    };

  };
}
