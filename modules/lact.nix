{ pkgs, config, lib, ... }:
let
  cfg = config.sysconf;
  thisOption = lib.removeSuffix ".nix" "${builtins.baseNameOf (__curPos.file)}";
in {
  options = {
    sysconf = {
      ${thisOption}.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };
  };
  config = lib.mkIf cfg.${thisOption}.enable {
    environment.systemPackages = with pkgs; [ lact ];

    systemd.services.lact = {
      description = "LACT Daemon";
      after = [ "multi-user.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = { ExecStart = "${pkgs.lact}/bin/lact daemon"; };
      enable = true;
    };
  };
}
