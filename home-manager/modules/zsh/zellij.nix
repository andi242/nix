# { ... }:
{
  imports = [ ./zellij-plugins ];

  programs = {
    zellij = {
      enable = true;
      enableZshIntegration = false;
    };
  };
  xdg.configFile."zellij" = {
    source = ./zellij-config;
    recursive = true;
  };
}
