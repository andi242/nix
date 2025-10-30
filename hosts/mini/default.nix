{ pkgs, config, username, ... }: {
  imports = [ 
    ../common.nix
    # ../../test.nix
  ];

  virtualisation.vmVariant = {
    virtualisation = {
      # qemu.options = [ "-device virtio-vga -audio model=hda,driver=pipewire -full-screen" ];
      # diskSize = 20000;
      memorySize = 4000;
      cores = 4;
      graphics = false;
    };
  };

  services.getty.autologinUser = "ad";
  system.stateVersion = "24.11";
}
