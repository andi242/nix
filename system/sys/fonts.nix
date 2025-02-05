{ config, pkgs, ... } : 
{
  # fonts
  fonts.fontDir.enable = true;
  fonts.fontconfig.useEmbeddedBitmaps = true;
  fonts.packages = with pkgs; [
    # pkgs.nerd-fonts.geist-mono
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "GeistMono" ]; })
    # nerd-fonts.geist-mono
    
  ];
  # fonts.fontconfig = {
  #   enable = true;
  #   defaultFonts = {
  #     emoji = ["GeistMono NFP"];
  #     monospace = ["GeistMono"];
  #   };
  # };
}
