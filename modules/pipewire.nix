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
    environment.systemPackages = with pkgs; [ easyeffects ];
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      extraConfig.pipewire = {
        "10-clock-rate" = {
          "context.properties" = {
            "default.clock.rate" = 44100;
            "default.clock.allowed-rates" = [ 44100 48000 ];
          };
        };
      };
      wireplumber.extraConfig = {
        "10-disable-hdmi" = {
          "monitor.alsa.rules" = [{
            matches = [{ "device.nick" = "~HDMI.*"; }];
            actions = { update-props = { "device.disabled" = "true"; }; };
          }];
        };
      };
    };
  };
}
