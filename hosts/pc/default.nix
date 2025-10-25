{ pkgs, config, ... }: {
  imports = [ 
    ./hardware.nix 
    ./configuration.nix
    ./keychron_udev.nix
    ./packages.nix
  ];
  sysconf = {
    fish.enable = true;
    flatpak.enable = true;
    fonts.enable = true;
    gaming.enable = true;
    gnome.enable = true;
    lact.enable = true;
    nh.enable = true;
    node-exporter.enable = true;
    nvim.enable = true;
    office.enable = true;
    pipewire.enable = true;
    printing.enable = true;
    tempctl.enable = true;
  };
  virtualisation.vmVariant = {
    virtualisation = {
      qemu.options = [ "-device virtio-vga -audio model=hda,driver=pipewire -full-screen" ];
      memorySize = 8000;
      cores = 6;
      diskSize = 20000;
      # graphics = ;
    };
  };
  users.users.ad = {
    isNormalUser = true;
    password = "12345"; # VM testing
    extraGroups = [ "wheel" "libvirtd" "audio" ];
    uid = 1000;
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG2bj+JgXVQ+9r8UA0zpBn2cx1DhffMIJXb3tF8ClSm1 ad" ];
  };
  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "24.11";
}
