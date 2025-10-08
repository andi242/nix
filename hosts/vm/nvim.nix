{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    lazygit
    git
  ];
  programs.neovim = {
    defaultEditor = true;
    enable = true;
    viAlias = true;
    vimAlias = true;
    withRuby = false;
    configure = {
      customRC = ''
        " your custom configuration
        if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
          silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
          autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
        endif
        set number
        set tabstop=2
        set shiftwidth=2
        set autoindent
        set smartindent
        syntax on
        filetype on
        colorscheme catppuccin-mocha

        call plug#begin()
        Plug 'nvim-tree/nvim-web-devicons'
        Plug 'nvim-tree/nvim-tree.lua'
        call plug#end()
      '';
      testRC = ''
        " fasel
      '';
      customLuaRC = ''
        -- cfg
        vim.o.clipboard = "unnamedplus"
        -- keymap
        vim.keymap.set("n", " ", "<Nop>", { silent = true, remap = false })
        vim.g.mapleader = " "
        local map = vim.keymap.set
        map("n", "<A-Up>", "<cmd>move -2<cr>", { desc = "Move line up" })
        map("n", "<A-Down>", "<cmd>move +1<cr>", { desc = "Move line down" })
        map("n", "<S-A-Down>", "<cmd>t +0<cr>", { desc = "Move line down" })
        map("n", "<S-A-Up>", "<cmd>t -1<cr>", { desc = "Move line down" })
        map("n", "<leader>qq", "<cmd>quitall<CR>", { desc = "quitall" })
        map("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "LazyGit" })
        map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "NvimTreeToggle" })
        map({"i", "n"}, "<C-s>", "<esc><cmd>w<CR>", { desc = "write buffer" })
      '';
      packages.myVimPackage = with pkgs.vimPlugins; {
        # loaded on launch
        start = [
          nvim-tree-lua
          plenary-nvim # for nvim-tree-lua
          nvim-web-devicons
          which-key-nvim
          lualine-nvim
          mini-nvim
          lazygit-nvim
          catppuccin-nvim
          vim-plug
        ];
        # manually loadable by calling `:packadd $plugin-name`
        opt = [ ];
      };
    };
  };
}
