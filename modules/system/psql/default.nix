{ pkgs, ... }:
{
  services.postgresql = {
    enable = true;
    ensureUsers = [
      { name = "paperless"; ensureDBOwnership = true; }
      { name = "invidious"; ensureDBOwnership = true; }
    ];
    ensureDatabases = [
      "paperless"
      "invidious"
    ];
  };
}
