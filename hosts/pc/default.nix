{ pkgs, config, username, ... }: {
  imports = [ 
    ../common.nix
    ./hardware.nix 
    ./configuration.nix
    ./keychron_udev.nix
    ./packages.nix
  ];
  sysconf = {
    flatpak.enable = true;
    fonts.enable = true;
    gaming.enable = true;
    gnome.enable = true;
    lact.enable = true;
    node-exporter.enable = true;
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

  system.stateVersion = "24.11";
}
