{ config, ... }:
let
  dnsServers = "192.168.122.241";
in
{
  sops.secrets = {
    dnsmasq = {
      sopsFile = ../../../secrets/dnsmasq.yaml;
      key = "dnsmasq";
    };
  };

  services.dnsmasq = {
    enable = false;
    settings = {
      dhcp-range = [ "192.168.1.100,192.168.1.150,24h" ];
      server = [ dnsServers ];
      port = 0;
      conf-file = config.sops.secrets.dnsmasq.path;
      no-resolv = true;
      no-hosts = true;
      bind-interfaces = true;
      domain-needed = true;
      log-dhcp = true;
      no-poll = true;
      domain = "local";
    };
  };
}
