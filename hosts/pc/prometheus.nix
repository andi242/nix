{ pkgs, ... }:
{
  services.prometheus.exporters.node = {
    enable = true;
    openFirewall = true;
    extraFlags = [
      "--collector.disable-defaults"
      "--web.disable-exporter-metrics"
    ];
    enabledCollectors = [
      "cpu"
      "meminfo"
      "filesystem"
      "hwmon"
      "cpufreq"
      "netdev"
    ];
  };
  systemd.services.prometheus-node-exporter.serviceConfig.ProtectHome = pkgs.lib.mkForce "read-only";
  # environment.systemPackages = with pkgs; [
  #   lm_sensors
  # ];
}
