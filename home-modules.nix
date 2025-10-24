{ pkgs, inputs, config, ... }:
{
  imports = map (f: ./home/${f}) (builtins.attrNames (builtins.readDir ./home));
  home = {
    username = "ad";
    homeDirectory = "/home/ad";
    stateVersion = "24.11";
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      GTK_THEME_VARIANT = "dark";
    };
  };
  programs = { home-manager.enable = true; };
}

