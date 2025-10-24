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
    services.prometheus.exporters.node = {
      enable = true;
      openFirewall = true;
      extraFlags = [ "--collector.disable-defaults" "--web.disable-exporter-metrics" ];
      enabledCollectors = [ "cpu" "meminfo" "filesystem" "hwmon" "cpufreq" "netdev" ];
    };
    systemd.services.prometheus-node-exporter.serviceConfig.ProtectHome = pkgs.lib.mkForce "read-only";
  };
}
