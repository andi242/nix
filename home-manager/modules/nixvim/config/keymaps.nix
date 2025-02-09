{
  keymaps = [
    # { action = ""; key = ""; }
    {
      mode = "n";
      key = "<C-s>";
      action = "<cmd>w<CR>";
      options.desc = "save";
     }
    { action = "<cmd>move -2<cr>"; 
      key = "<A-Up>"; 
      options.desc = "move line up";
    }
    { action = "<cmd>move +1<cr>"; 
      key = "<A-Down>"; 
      options.desc = "move line down";
    }
    { action = "<cmd>t +0<cr>";
      key = "<S-A-Down>"; 
      options.desc = "copy line down";
    }
    { action = "<cmd>t -1<cr>";
      key = "<S-A-Up>"; 
      options.desc = "copy line up";
    }
    { action = "<cmd>wincmd h<CR>"; 
      key = "<A-Left>"; 
      options.desc = "pane left";
    }
    { action = "<cmd>wincmd l<CR>"; 
      key = "<A-Right>"; 
      options.desc = "pane right";
    }
    # LazyGit
    {
      mode = "n";
      key = "<leader>gg";
      action = "<cmd>LazyGit<CR>";
      options.desc = "LazyGit";
    }
    {
      mode = "n";
      key = "<leader>qq";
      action = "<cmd>quitall<CR>";
      options.desc = "quitall";
  }
    {
      mode = "n";
      key = "<leader>q";
      action = "<cmd>quit<CR>";
      options.desc = "quit";
    }
    {
      mode = "n";
      key = "<leader>e";
      action = "<cmd>Neotree toggle<CR>";
      options.desc = "Neotree toggle";
    }

    # { action = ""; key = ""; }
    # { action = ""; key = ""; }
  ];
}
