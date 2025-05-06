{ config, ... }:
{
  sops.secrets = {
    inv_settings = {
      sopsFile = ../../../secrets/invid.yaml;
      key = "inv_settings";
      mode = "0444";
    };
    inv_hmac = {
      sopsFile = ../../../secrets/invid.yaml;
      mode = "0444";
      key = "inv_hmac";
    };
  };

  services.invidious = {
    enable = true;
    settings = {
      admins = [ "ad" ];
      domain = "vid.andi242.dedyn.io";
    };
    sig-helper.enable = true;
    database.createLocally = false;
    hmacKeyFile = config.sops.secrets.inv_hmac.path;
    extraSettingsFile = config.sops.secrets.inv_settings.path;
  };
  networking.firewall.allowedTCPPorts = [ 3000 ];
}
