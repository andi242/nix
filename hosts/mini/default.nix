{ pkgs, lib, home-manager, inputs, username, ... }:

let
  # inherit (import ../variables.nix) username;

in {
  imports = [ ../common.nix ];
  ########## 
  config = {
    sysconf = {
      # fish.enable = true;
      fonts.enable = true;
      nh.enable = true;
      nvim.enable = true;
    };
    home-manager = {
      users.${username} = {
        userconf = { 
          shell.enable = false; 
        }; 
      };
    };

    virtualisation.vmVariant = {
      virtualisation = {
        qemu.options = [
          "-vga none"
          "-device virtio-vga-gl"
          "-display gtk,gl=on"
          "-device usb-tablet"
          "-device usb-kbd"
          # "-full-screen" 
        ];
        diskSize = 20000;
        memorySize = 4000;
        cores = 4;
        resolution.x = 1920;
        resolution.y = 1080;
        # graphics = false;
      };
    };

    services.getty.autologinUser = username;
    system.stateVersion = "24.11";
  };
}
