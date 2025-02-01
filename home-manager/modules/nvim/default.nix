{ config, pkgs, ... } : 
{
  # programs.neovim = {
  #   enable = true;
  #   defaultEditor = true;
  #   viAlias = true;
  #   vimAlias = true;
  # };
  # programs.neovim = {
  #   plugins = [
  #     pkgs.vimPlugins.nvim-treesitter.withAllGrammars
  #   ];
  #   extraConfig = ''
  #     set number
  #   '';
  # };
  xdg.configFile.neovim = {
    enable = true;
    source = config.lib.file.mkOutOfStoreSymlink ./nvim;
    target = "nvim";
  };

}
