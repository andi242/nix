{ pkgs, config, inputs, ... }:
let
  secretspath = builtins.toString inputs.nix-secrets;
in
{
  sops.secrets = {
    fpass = {
      sopsFile = "${secretspath}/secrets/git.yaml";
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
    settings = {
      server = {
        ROOT_URL = "https://git.andi242.dedyn.io";
        SSH_PORT = 2222;
        START_SSH_SERVER = true;
      };
      database.LOG_SQL = false;
      security.REVERSE_PROXY_TRUSTED_PROXIES = "192.168.1.0/24";
      log = {
        ENABLE_SSH_LOG = true;
      };
      other = {
        SHOW_FOOTER_VERSION = false;
      };
      service = {
        DEFAULT_USER_VISIBILITY = "limited";
        DEFAULT_ORG_VISIBILITY = "limited";
        SHOW_MILESTONES_DASHBOARD_PAGE = false;
      };
    };
  };
  networking.firewall.allowedTCPPorts = [ 3000 2222 ];
}
