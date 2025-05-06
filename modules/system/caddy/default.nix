{ config, ... }:
{
  sops.secrets = {
    dns = {
      sopsFile = ../../../secrets/dnsmasq.yaml;
      key = "dns";
    };
  };

  services.caddy = {
    enable = true;
    virtualHosts = {
      "localhost:80".extraConfig = ''
        respond "OK"
      '';
      "home.lab.local:80".extraConfig = ''
        reverse_proxy http://127.0.0.1:8082
      '';
      "search.lab.local:80".extraConfig = ''
        reverse_proxy http://127.0.0.1:8088
      '';
      "andi242.dedyn.io".extraConfig = ''
        respond "OK"
        tls /var/lib/acme/desec/cert.pem /var/lib/acme/desec/key.pem {
          protocols tls1.3
        }
      '';
      "vid.andi242.dedyn.io".extraConfig = ''
        reverse_proxy http://127.0.0.1:3000
        tls /var/lib/acme/desec/cert.pem /var/lib/acme/desec/key.pem {
          protocols tls1.3
        }
      '';

      "home.andi242.dedyn.io".extraConfig = ''
        reverse_proxy http://127.0.0.1:8082
        tls /var/lib/acme/desec/cert.pem /var/lib/acme/desec/key.pem {
          protocols tls1.3
        }
      '';
      "search.andi242.dedyn.io".extraConfig = ''
        reverse_proxy http://127.0.0.1:8088
        tls /var/lib/acme/desec/cert.pem /var/lib/acme/desec/key.pem {
          protocols tls1.3
        }
      '';
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "andi242@gmail.com";
    maxConcurrentRenewals = 2;
    certs."desec" = {
      group = config.services.caddy.group;

      domain = "*.andi242.dedyn.io";
      reloadServices = [ "caddy.service" ];
      dnsProvider = "desec";
      dnsResolver = "8.8.8.8:53";
      dnsPropagationCheck = true;
      environmentFile = config.sops.secrets.dns.path;
    };
  };
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
