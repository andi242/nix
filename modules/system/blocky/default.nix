{ pkgs-unstable, ... }:
{
  services.blocky = {
    enable = true;
    package = pkgs-unstable.blocky;
    # https://0xerr0r.github.io/blocky/latest/configuration/
    settings = {

      ports = {
        dns = 53;
        http = 4000;
      };
      upstreams = {
        groups = {
          default = [
            "https://security.cloudflare-dns.com/dns-query"
            "tcp-tls:dns.quad9.net"
          ];
        };
      };
      bootstrapDns = {
        upstream = "tcp-tls:dns.google";
        ips = [ "8.8.4.4" ]; # google public dns
      };
      # howto local host fqdn
      customDNS = {
        mapping = {
          "proxmox.local" = "192.168.1.13";
        };
      };
      caching = {
        minTime = "5m";
        maxTime = "30m";
        prefetching = true;
      };
      blocking = {
        loading = { refreshPeriod = "24h"; };
        blockType = "nxDomain";
        # https://github.com/StevenBlack/hosts
        # https://github.com/hagezi/dns-blocklists
        denylists = {
          ads = [
            # "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews/hosts"
            "https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt"
            "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/wildcard/popupads.txt"
            "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/wildcard/pro.plus.txt"
          ];
          all = [
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts"
          ];
          custom = [
            ./blacklist.txt
          ];
          fullblock = [
            ./fullblock.txt
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
          "192.168.1.10" = [ ];
          "192.168.1.13" = [ ];
          "192.168.1.1" = [ "fullblock" ];
          "127.0.0.1" = [ ];
        };
      };
    };
  };
  networking.firewall.allowedTCPPorts = [ 4000 53 ];
  networking.firewall.allowedUDPPorts = [ 53 ];
}
