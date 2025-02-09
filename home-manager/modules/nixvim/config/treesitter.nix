{ pkgs, ...}: 
{
  plugins.treesitter-textobjects = {
    enable = true;
  };
  plugins.treesitter = {
    enable = true;
    nixvimInjections = true;
    settings = {
      highlight.enable = true;
      indent.enable = true;
    };
    folding = false;
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      bash
      json
      lua
      make
      markdown
      nix
      regex
      toml
      vim
      vimdoc
      xml
      yaml
      css
      scss
      html
    ];
  };
}
