{ pkgs, config, ... }:

{
  systemd.user.timers."flatpak-update" = {
    Unit.Description = "daily flatpak-update";
    Timer = {
      Unit = "flatpak-update";
      OnCalendar = "daily";
    };
    Install.WantedBy = [ "timers.target" ];
  };

  systemd.user.services."flatpak-update" = {
    Unit.Description = "daily flatpak-update";
    Service = {
      # ExecStart = "${pkgs.flatpak}/bin/flatpak update --assumeyes";
      ExecStart = "${ pkgs.writeShellScript "flatpak-update" ''
        sleep 30
        ${pkgs.flatpak}/bin/flatpak update --assumeyes
      ''}";
      Type = "oneshot";
    };
    Install.WantedBy = [ "default.target" ];
  };
}
