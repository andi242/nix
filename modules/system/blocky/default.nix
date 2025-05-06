{ ... }:
{
  services.blocky = {
    enable = true;
    # https://0xerr0r.github.io/blocky/latest/configuration/
    settings = {

      ports = {
        dns = 53;
        http = 4000;
        https = 8443;
      };
      upstreams = {
        groups = {
          default = [
            "https://security.cloudflare-dns.com/dns-query"
            "https://dns.google/dns-query"
            "tcp-tls:dns.quad9.net"
          ];
        };
      };
      bootstrapDns = {
        upstream = "tcp-tls:dns.google";
        ips = [ "8.8.4.4" ]; # google public dns
      };
      # customDNS = {
      #   mapping = {
      #     "blocky.local" = "192.168.1.31";
      #     "lab.local" = "192.168.122.241";
      #   };
      # };
      blocking = {
        loading = { refreshPeriod = "24h"; };
        blockType = "nxDomain";
        # https://github.com/StevenBlack/hosts
        denylists = {
          ads = [
            # "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews/hosts"
            "https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt"
          ];
          all = [
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts"
          ];
          custom = [
            ./blacklist.txt
          ];
        };
        allowlists = {
          custom = [
            ./whitelist.txt
          ];
        };
        clientGroupsBlock = {
          # default = [ ];
          default = [ "all" "ads" "custom" ];
          "192.168.1.48" = [ "custom" "ads" ];
        };
      };
    };
  };
  networking.firewall.allowedTCPPorts = [ 4000 8443 53 ];
  networking.firewall.allowedUDPPorts = [ 53 ];
}
