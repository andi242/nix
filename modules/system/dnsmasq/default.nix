{ inputs, config, ... }:
let
  dnsServers = "192.168.122.241";
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  sops = {
    defaultSopsFile = ../../../secrets/dnsmasq.yaml;
    defaultSopsFormat = "yaml";
    age = {
      # first get with ssh-keyscan, then automatically use this
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      # path of keys
      keyFile = "/root/.config/sops/age/keys.txt";
      # generate if not exists
      generateKey = true;
    };
  };
  sops.secrets = {
    dnsmasq = { };
  };

  services.dnsmasq = {
    enable = false;
    settings = {
      dhcp-range = [ "192.168.1.100,192.168.1.150,12h" ];
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
