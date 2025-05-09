{ pkgs, config, ... }:
{
  sops.secrets = {
    fpass = {
      sopsFile = ../../../secrets/git.yaml;
      key = "fpass";
      group = config.services.forgejo.group;
      owner = config.services.forgejo.user;
    };
  };

  services.forgejo = {
    enable = true;
    database = {
      type = "postgres";
      host = "192.168.1.10";
      passwordFile = config.sops.secrets.fpass.path;
    };
    settings.server.ROOT_URL = "https://git.andi242.dedyn.io";
    settings.server.SSH_PORT = 2222;
  };
  networking.firewall.allowedTCPPorts = [ 3000 2222 ];
}
