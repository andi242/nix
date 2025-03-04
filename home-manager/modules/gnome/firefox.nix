{ pkgs, lib, config, ... }:

{
  # home.packages = with pkgs; [
  # firefox
  # ];
  # https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265
  programs.firefox = {
    enable = true;
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableFirefoxScreenshots = true;
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "always";
      ExtensionSettings = with builtins;
        let
          extension = shortId: uuid: {
            name = uuid;
            value = {
              install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
              installation_mode = "normal_installed";
            };
          };
        in
        listToAttrs [
          (extension "ublock-origin" "uBlock0@raymondhill.net")
          (extension "betterttv" "firefox@betterttv.net")
          (extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
          (extension "Dark" "firefox-compact-dark@mozilla.org")
        ];
    };
    profiles."ad" = {
      settings = {
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        "toolkit.telemetry.coverage.opt-out" = true;
        "browser.urlbar.placeholderName" = "homelab";
        "browser.newtabpage.pinned" = [
          {
            title = "YT";
            url = "https://youtube.com";
          }
          {
            title = "twitch";
            url = "https://twitch.com";
          }
          {
            title = "nixos search";
            url = "https://mynixos.com";
          }
        ];
      };
      isDefault = true;
      name = "ad";
    };
  };
}
