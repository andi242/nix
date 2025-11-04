{ pkgs, lib, home-manager, inputs, username, ... }: {
  config = {
    users.users.${username} = {
      isNormalUser = true;
      password = "12345"; # VM testing
      extraGroups = [ "wheel" "libvirtd" "audio" ];
      uid = 1000;
      openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG2bj+JgXVQ+9r8UA0zpBn2cx1DhffMIJXb3tF8ClSm1 ad" ];
    };
    security.sudo.wheelNeedsPassword = false;

    # some default options
    sysconf = {
      fish.enable = lib.mkDefault true;
      nh.enable = lib.mkDefault true;
      nvim.enable = lib.mkDefault true;
    };
    home-manager = { users.${username} = { userconf = { shell.enable = lib.mkDefault true; }; }; };
    documentation = {
      # enable = false;
      man.enable = true;
      doc.enable = false;
      info.enable = false;
      nixos.enable = false;
    };
  };
}
