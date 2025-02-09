{config, pkgs, system, ...}:
{
  # https://nix-community.github.io/nixvim/24.11/search

  imports = [
    ./bufferline.nix
    ./misc.nix
    ./treesitter.nix
    ./mini.nix
    ./lazygit.nix
    ./snacks.nix
    ./lsp.nix
    ./neo-tree.nix
    ./which-key.nix
    ./keymaps.nix
  ];
  clipboard.register = "unnamedplus";
  globals.mapleader = " ";
  editorconfig.enable = true;
  luaLoader.enable = true;

  opts = {
    number = true;
    undofile = true;
    updatetime = 100;
    # indents 
    autoindent = true;
    smartindent = true;
    expandtab = true;
    shiftwidth = 2;
    tabstop = 2;
  };
  autoCmd = [
    {
      event = [ "BufWritePost" ];
      # command = "echo 'Saved...'";
      callback = { __raw = ''
        function()
          vim.notify("Saving...")
        end
        '';
      };
    }
  ];
}
