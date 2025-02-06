 { config, pkgs, ... }:

{
   home.file = {
    # ".screenrc".source = dotfiles/screenrc;
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".themes/theme-tweaks/gnome-shell/gnome-shell.css".text = ''
       #panel {
        font-size: 20px;
      }
    '';
  };
}

