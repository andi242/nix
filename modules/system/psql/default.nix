{ pkgs, config, ... }:
{
  sops.secrets = {
    db-sql = {
      sopsFile = ../../../secrets/git.yaml;
      key = "db-sql";
      group = "postgres";
      owner = "postgres";
    };
  };
  services.postgresql = {
    enable = true;
    dataDir = "/data/postgresql";
    authentication = ''
      host    all             all             192.168.1.0/24            trust
    '';
    enableTCPIP = true;
    ensureUsers = [
      { name = "paperless"; ensureDBOwnership = true; ensureClauses.login = true; }
      { name = "invidious"; ensureDBOwnership = true; ensureClauses.login = true; }
      { name = "forgejo"; ensureDBOwnership = true; ensureClauses.login = true; }
    ];
    ensureDatabases = [
      "paperless"
      "invidious"
      "forgejo"
    ];
  };
  services.postgresql.initialScript = config.sops.secrets.db-sql.path;
  networking.firewall.allowedTCPPorts = [ 5432 ];
}
