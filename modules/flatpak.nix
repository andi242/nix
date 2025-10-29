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
      after = [ "network.target" "resolvconf.service"];
      wants = [ "network.target" ];
      wantedBy = [ "multi-user.target" ]; # to enable it
      path = [ pkgs.flatpak ];
      script = ''
        sleep 10 # this is needed since name resolving is coming up too slow
        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
      '';
    };
  };
}

