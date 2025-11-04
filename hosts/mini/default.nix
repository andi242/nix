{ pkgs, lib, home-manager, inputs, username, ... }: {
  imports = [ ../common.nix ];
  ########## 
  config = {
    sysconf = {
      fish.enable = true;
      fonts.enable = true;
      nh.enable = true;
      nvim.enable = false;
      nvim-nightly.enable = true;
    };
    home-manager = { 
      users.${username} = { 
        userconf = { shell.enable = true; }; 
        home.file.".config/nvim/init.lua".text = ''
          local set = vim.opt
          set.number = true
          set.signcolumn = 'yes'
          vim.pack.add({
            { src = "https://github.com/lewis6991/gitsigns.nvim" },
            { src = "https://github.com/andi242/gitopen.nvim" },
            { src = "https://github.com/mcauley-penney/techbase.nvim" },
            { src = 'https://github.com/neovim/nvim-lspconfig' },
          })
          require('techbase').setup({})
          require('gitsigns').setup({ signcolumn = true })
          -- require('gitopen').setup()
          vim.cmd.colorscheme("techbase")
        '';
      }; 
    };

    virtualisation.vmVariant = {
      virtualisation = {
        qemu.options = [
          # "-vga none"
          # "-device virtio-vga-gl"
          # "-display gtk,gl=on"
          # "-device usb-tablet"
          # "-device usb-kbd"
          # "-full-screen"
          # "-device virtio-vga -audio model=hda,driver=pipewire -full-screen"
        ];
        diskSize = 20000;
        memorySize = 4000;
        cores = 4;
        resolution.x = 1920;
        resolution.y = 1080;
        graphics = false;
      };
    };
    services.getty.autologinUser = username;
    system.stateVersion = "24.11";
  };
}
