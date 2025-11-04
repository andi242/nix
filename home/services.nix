{ pkgs, config, lib, ... }:
let
  cfg = config.userconf;
  thisOption = lib.removeSuffix ".nix" "${builtins.baseNameOf (__curPos.file)}";
in {
  options.userconf.${thisOption} = {
    flatpak-update.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
  config = lib.mkMerge [
    # (lib.mkIf cfg.${thisOption}.enable { home.file."foo".text = "blafasel"; })
    (lib.mkIf cfg.${thisOption}.flatpak-update.enable {
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
    })
  ];
}
