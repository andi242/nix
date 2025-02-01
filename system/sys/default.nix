{ config, pkgs, ... } : 
{
#  fonts.packages = with pkgs; [
#    nerdfonts
#  ];
  environment.systemPackages = with pkgs; [
    geist-font
    fontconfig
  ];
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = ["GeistMono"];
      monospace = ["GeistMono"];
    };
  };
}
