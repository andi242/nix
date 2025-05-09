{ config, inputs, ... }:
let
  dnsServers = "192.168.1.10#53";
  secretspath = builtins.toString inputs.nix-secrets;
in
{
  sops.secrets = {
    dnsmasq = {
      sopsFile = "${secretspath}/secrets/dnsmasq.yaml";
      key = "dnsmasq";
    };
  };

  services.dnsmasq = {
    enable = true;
    settings = {
      dhcp-range = [ "192.168.1.11,192.168.1.100,24h" ];
      server = [ dnsServers ];
      port = 0;
      conf-file = config.sops.secrets.dnsmasq.path;
      no-resolv = true;
      no-hosts = true;
      expand-hosts = true;
      bind-interfaces = true;
      domain-needed = true;
      log-dhcp = true;
      log-queries = true;
      no-poll = true;
      domain = "local";
      local = "/local/";
    };
  };

  networking.firewall.allowedUDPPorts = [ 67 ];
  networking.firewall.allowedTCPPorts = [ 53 ];
}
