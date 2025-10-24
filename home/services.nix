{ pkgs, config, lib, ... }:
let
  cfg = config.userconf;
  thisOption = lib.removeSuffix ".nix" "${builtins.baseNameOf (__curPos.file)}";
in {
  options.userconf = {
    ${thisOption}.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
  config = lib.mkIf cfg.${thisOption}.enable {
    # services.flatpak.enable = true;
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
        ExecStart = "${pkgs.writeShellScript "flatpak-update" ''
          sleep 30
          ${pkgs.flatpak}/bin/flatpak update --assumeyes
        ''}";
        Type = "oneshot";
      };
      Install.WantedBy = [ "default.target" ];
    };
  };
}
