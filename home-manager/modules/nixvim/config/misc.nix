{
  # plugins.barbar = {
  #   enable = true;
  #   keymaps = {
  #     close.key = "<C-x>";
  #   };
  # };
  plugins.bufdelete = {
    enable = true;
  };
 
  plugins.auto-save = {
    enable = false;
  };
  colorschemes.catppuccin = { 
    enable = true;
    settings = {
      flavour = "auto";
      # integrations = {
      #   neo-tree = true;
      # };
    };
  };
  plugins.lazy.enable = true;
  plugins.lualine = { 
    enable = true;
    settings.options = {
      disabled_filetypes = {
        __unkeyed-1 = "startify";
        __unkeyed-2 = "neo-tree";
        __unkeyed-3 = "snacks_dashboard";
      };
      globalstatus = true;
    };
  };
  plugins.toggleterm = {
    enable = true;
    settings = {
      open_mapping = "[[<C-t>]]";
    };
  };
}
