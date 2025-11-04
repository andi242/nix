{ pkgs, lib, home-manager, inputs, username, ... }: {
  imports = [ ../common.nix ./hardware.nix ./configuration.nix ./keychron_udev.nix ./packages.nix ];
  config = {
    sysconf = {
      fish.enable = true;
      flatpak.enable = true;
      fonts.enable = true;
      gaming.enable = true;
      gnome.enable = true;
      lact.enable = true;
      node-exporter.enable = true;
      office.enable = true;
      pipewire.enable = true;
      tempctl.enable = true;
    };
    home-manager = {
      users.${username} = {
        userconf = {
          ghostty.enable = true;
          librewolf.enable = true;
          services = { flatpak-update.enable = true; };
          gnome-settings = {
            enable = true;
            dconf-settings.enable = true;
          };
          git.enable = true;
          extra-packages.enable = true;
          shell.enable = true;
        };
      };
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
  };
}
