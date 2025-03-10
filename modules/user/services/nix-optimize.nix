{ pkgs, config, ... }:

{
  systemd.user.timers."store-optimise" = {
    Unit.Description = "weekly nix store optimise";
    Timer = {
      Unit = "store-optimise";
      OnCalendar = "weekly";
    };
    Install.WantedBy = [ "timers.target" ];
  };

  systemd.user.services."store-optimise" = {
    Unit.Description = "optimise nix store";
    Service = {
      Environment = "PATH=/run/current-system/sw/bin";
      ExecStart = "${pkgs.nix}/bin/nix store optimise -v";
      Type = "oneshot";
    };
    Install.WantedBy = [ "default.target" ];
  };
}
