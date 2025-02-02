{ config, pkgs, ... }:

{
home.file = {
  ".config/waybar/config.jsonc".text = builtins.readFile ./waybar/waybar.jsonc;
  ".config/waybar/mocha.css".text = builtins.readFile ./waybar/mocha.css;
  ".config/waybar/style.css".text = builtins.readFile ./waybar/style.css;
  ".config/hypr/hyprland.conf".text = builtins.readFile ./hyprland.conf;
  };
  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "palenight";
      package = pkgs.palenight-theme;
    };

    cursorTheme = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  home.sessionVariables.GTK_THEME = "palenight";

}
