{ pkgs, config, lib, ... }:
let
  cfg = config.sysconf;
  thisOption = lib.removeSuffix ".nix" "${builtins.baseNameOf (__curPos.file)}";
in {
  options.sysconf = {
    ${thisOption}.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
  config = lib.mkIf cfg.${thisOption}.enable {
    services.flatpak.enable = true;
    systemd.services.flatpak-repo = {
      wantedBy = [ "network.target" ];
      path = [ pkgs.flatpak ];
      script = ''
        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
      '';
    };
  };
}

