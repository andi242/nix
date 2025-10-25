{ username, ... }: {
  users.users.${username} = {
    isNormalUser = true;
    password = "12345"; # VM testing
    extraGroups = [ "wheel" "libvirtd" "audio" ];
    uid = 1000;
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG2bj+JgXVQ+9r8UA0zpBn2cx1DhffMIJXb3tF8ClSm1 ad" ];
  };
  security.sudo.wheelNeedsPassword = false;
  # documentation = {
  #   enable = lib.mkDefault false;
  #   doc.enable = lib.mkDefault false;
  #   info.enable = lib.mkDefault false;
  #   man.enable = lib.mkDefault false;
  #   nixos.enable = lib.mkDefault false;
  # };
}
