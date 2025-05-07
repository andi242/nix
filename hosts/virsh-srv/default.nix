{ inputs, config, ... }:
{
  imports = [
    ./hardware.nix
    ./configuration.nix
    ../../modules/system/srv.nix
    ../../modules/system/homepage
    ../../modules/system/searxng
    ../../modules/system/blocky
    ../../modules/system/dnsmasq
    ../../modules/system/caddy
    ../../modules/system/invid
    ../../modules/system/psql
    inputs.sops-nix.nixosModules.sops
  ];
  virtualisation.podman.enable = true;
  nix.settings.trusted-users = [ "ad" ];
  sops = {
    # defaultSopsFile = ../../../secrets/dnsmasq.yaml;
    defaultSopsFormat = "yaml";
    age = {
      # first get with ssh-keyscan, then automatically use this
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      # path of keys
      keyFile = "/root/.config/sops/age/keys.txt";
      # generate if not exists
      generateKey = true;
    };
  };
}
