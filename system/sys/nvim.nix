{ config, pkgs, ... } : 
{
  environment.systemPackages = [ pkgs.neovim ];
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}
