{ config, lib, ... }:
let
  cfg = config.userconf;
  plugins = {
    autolock = builtins.fetchurl {
      url = "https://github.com/fresh2dev/zellij-autolock/releases/download/0.2.2/zellij-autolock.wasm";
      sha256 = "sha256-aclWB7/ZfgddZ2KkT9vHA6gqPEkJ27vkOVLwIEh7jqQ=";
    };

    zjstatus = builtins.fetchurl {
      url = "https://github.com/dj95/zjstatus/releases/download/v0.20.2/zjstatus.wasm";
      sha256 = "sha256-OSg7Q1AWKW32Y9sHWJbWOXWF1YI5mt0N4Vsa2fcvuNg=";
    };
  };
in
{
  options = {
    userconf = {
      zellij.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };

  config = lib.mkIf cfg.zellij.enable {
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
      # plugins from let
      configFile."zellij/plugins/zellij-autolock.wasm".source = plugins.autolock;
      configFile."zellij/plugins/zjstatus.wasm".source = plugins.zjstatus;
    };
    xdg.desktopEntries = {
      zellij = {
        name = "Zellij";
        exec = "kitty zellij";
        terminal = false;
        categories = [ "Application" ];
        icon = "/home/ad/.config/zellij/icon.png";
        actions = {
          kitty = {
            exec = "kitty";
          };
        };
      };
    };
  };
}
