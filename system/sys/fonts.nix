{ config, pkgs, ... } : 
{
  fonts.fontconfig.useEmbeddedBitmaps = true;
  fonts.packages = with pkgs; [
    # pkgs.nerd-fonts.geist-mono
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "GeistMono" ]; })

    # in nixos-unstable:
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
