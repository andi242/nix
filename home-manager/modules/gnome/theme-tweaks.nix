 { config, pkgs, ... }:

{
   home.file = {
    ".themes/theme-tweaks/gnome-shell/gnome-shell.css".text = ''
       #panel {
        font-size: 20px;
      }
    '';
  };
}

