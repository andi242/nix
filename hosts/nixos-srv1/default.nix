{ inputs, config, ... }:
{
  imports = [
    ./hw-proxmox.nix
    ./configuration.nix
    ../../modules/system/srv.nix
    ../../modules/system/homepage
    ../../modules/system/searxng
    ../../modules/system/blocky
    ../../modules/system/dnsmasq
    ../../modules/system/caddy
    # ../../modules/system/invid
    # ../../modules/system/psql
    inputs.sops-nix.nixosModules.sops
  ];
  virtualisation.podman.enable = true;
  sops = {
    defaultSopsFormat = "yaml";
    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/root/.config/sops/age/keys.txt";
      generateKey = true;
    };
  };
}
