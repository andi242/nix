{ pkgs, inputs, pkgs-unstable, ... }:
let
  searxPort = 8088;
in
{
  environment.systemPackages = with pkgs; [
    searxng
  ];
  services.searx = {
    enable = true;
    # https://docs.searxng.org/admin/installation-searxng.html#configuration
    settings = {
      server = {
        port = searxPort;
        bind_address = "0.0.0.0";
        secret_key = "myverysecretsecret1234";
        method = "GET";
      };
      ui.query_in_title = true;
    };
  };
  networking.firewall.allowedTCPPorts = [ searxPort ];
}
