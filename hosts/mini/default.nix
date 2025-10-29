{ pkgs, config, username, ... }: {
  imports = [ 
    ../common.nix
  ];
  # sysconf = {
  #   flatpak.enable = true;
  #   fonts.enable = true;
  #   gaming.enable = true;
  #   gnome.enable = true;
  #   lact.enable = true;
  #   node-exporter.enable = true;
  #   office.enable = true;
  #   pipewire.enable = true;
  #   tempctl.enable = true;
  # };
  virtualisation.vmVariant = {
    virtualisation = {
      # qemu.options = [ "-device virtio-vga -audio model=hda,driver=pipewire -full-screen" ];
      memorySize = 4000;
      cores = 4;
      # diskSize = 20000;
      graphics = false;
    };
  };

  system.stateVersion = "24.11";
}
