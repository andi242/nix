{ username, ... }: {
  users.users.${username} = {
    isNormalUser = true;
    password = "12345"; # VM testing
    extraGroups = [ "wheel" "libvirtd" "audio" ];
    uid = 1000;
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG2bj+JgXVQ+9r8UA0zpBn2cx1DhffMIJXb3tF8ClSm1 ad" ];
  };
  security.sudo.wheelNeedsPassword = false;
  sysconf = {
    fish.enable = true;
    nh.enable = true;
    nvim.enable = true;
  };

  documentation = {
    # enable = false;
    doc.enable = false;
    info.enable = false;
    man.enable = true;
    nixos.enable = false;
  };
}
