# { ... }:
{
  # init nixfile: git add!
  programs = {
    zellij = {
      enable = true;
      enableZshIntegration = true;
    };
  };
  xdg.configFile."zellij".source = ./zellij-config;
  # home.file.zellij = {
  #   target = ".config/zellij/config.kdl";
  #   text = ''
  #     theme "catppuccin-macchiato"
  #   '';
}
