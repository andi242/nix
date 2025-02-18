# { ... }:
{
  imports = [ ./zellij-plugins ];

  programs = {
    zellij = {
      enable = true;
      enableZshIntegration = false;
    };
  };
  xdg = {
    configFile."zellij" = {
      source = ./zellij-config;
      recursive = true; # because we inject zellij plugins as well
    };
    configFile."zellij/icon.png".source = ./zellij-config/icon.png;
  };
  xdg.desktopEntries = {
    zellij = {
      name = "Zellij";
      exec = "kitty zellij";
      terminal = false;
      categories = [ "Application" ];
      icon = "/home/ad/.config/zellij/icon.png"; #"/home/ad/.local/share/applications/zellij-icon.png";
      actions = {
        kitty = {
          exec = "kitty";
        };
      };
    };
  };
}
