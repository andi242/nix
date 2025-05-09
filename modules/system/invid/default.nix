{ config, inputs, ... }:
let
  secretspath = builtins.toString inputs.nix-secrets;
in
{
  sops.secrets = {
    inv_settings = {
      sopsFile = "${secretspath}/secrets/invid.yaml";
      key = "inv_settings";
      mode = "0444";
    };
    inv_hmac = {
      sopsFile = "${secretspath}/secrets/invid.yaml";
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
