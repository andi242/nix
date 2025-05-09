{ inputs, config, ... }:
{
  imports = [
    ./configuration.nix
    ./hw-lxc.nix
    ../../modules/system/srv.nix
    ../../modules/system/forgejo
    inputs.sops-nix.nixosModules.sops
  ];
  sops = {
    defaultSopsFormat = "yaml";
    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/root/.config/sops/age/keys.txt";
      generateKey = true;
    };
  };
}
