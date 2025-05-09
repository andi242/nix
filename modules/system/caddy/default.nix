{ config, pkgs, pkgs-unstable, inputs, ... }:
let
  secretspath = builtins.toString inputs.nix-secrets;
in
{
  sops.secrets = {
    dns = {
      sopsFile = "${secretspath}/secrets/dnsmasq.yaml";
      key = "dns";
    };
  };

  services.caddy = {
    enable = true;
    package = pkgs-unstable.caddy.withPlugins {
      plugins = [
        # no tag in repo, build and see errors
        "github.com/mholt/caddy-l4@v0.0.0-20250428144642-57989befb7e6"
      ];
      # later? https://github.com/caddy-dns/desec
      hash = "sha256-UNOvokDRmir2RcXdsSwUxHLEKD8PA6aYEngjUPImsTo=";
    };

    globalConfig = ''
      layer4 {
        :2222 {
          @ssh-git ssh
          route @ssh-git {
            proxy tcp/192.168.1.21:2222
          }
        }
      }
    '';
    extraConfig = ''
      (desec) {
        tls /var/lib/acme/desec/cert.pem /var/lib/acme/desec/key.pem {
             protocols tls1.3
        }
      }
    '';
    virtualHosts = {
      "localhost:80".extraConfig = ''
        respond "OK"
      '';
      # interferes with letsencrypt!
      # "andi242.dedyn.io".extraConfig = ''
      #   respond "OK"
      # '';

      "vid.andi242.dedyn.io".extraConfig = ''
        import desec
        reverse_proxy http://127.0.0.1:3000
      '';

      "home.andi242.dedyn.io".extraConfig = ''
        import desec
        reverse_proxy http://127.0.0.1:8082
      '';
      "search.andi242.dedyn.io".extraConfig = ''
        import desec
        reverse_proxy http://127.0.0.1:8088
      '';
      "git.andi242.dedyn.io".extraConfig = ''
        import desec
        reverse_proxy http://192.168.1.21:3000
      '';
      "keys.andi242.dedyn.io".extraConfig = ''
        import desec
        respond / 200 {
        body "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG2bj+JgXVQ+9r8UA0zpBn2cx1DhffMIJXb3tF8ClSm1 ad"
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
  networking.firewall.allowedTCPPorts = [ 80 443 2222 ];
}
