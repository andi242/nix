{ pkgs, config, lib, ... }:
let
  cfg = config.userconf;
  thisOption = lib.removeSuffix ".nix" "${builtins.baseNameOf (__curPos.file)}";
in {
  options.userconf = {
    ${thisOption}.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
  config = lib.mkIf cfg.${thisOption}.enable {
    # https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265
    programs.librewolf = {
      enable = true;
      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableFirefoxScreenshots = true;
        DontCheckDefaultBrowser = true;
        DisplayBookmarksToolbar = "always";
        setDefaultSearchEngine = "homelab";
        removeSearchEngines = [ "Google" "Bing" "Amazon.com" "eBay" "Twitter" ];
        ExtensionSettings = with builtins;
          let
            extension = shortId: uuid: {
              name = uuid;
              value = {
                install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
                installation_mode = "normal_installed";
              };
            };
          in listToAttrs [
            (extension "ublock-origin" "uBlock0@raymondhill.net")
            (extension "betterttv" "firefox@betterttv.net")
            (extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
          ];
        SearchEngines = {
          Add = [
            {
              Alias = "@np";
              Description = "Search in NixOS Packages";
              IconURL = "https://nixos.org/favicon.png";
              Method = "GET";
              Name = "NixOS Packages";
              URLTemplate = "https://search.nixos.org/packages?from=0&size=200&sort=relevance&type=packages&query={searchTerms}";
            }
            # {
            #   Alias = "@no";
            #   Description = "Search in NixOS Options";
            #   IconURL = "https://nixos.org/favicon.png";
            #   Method = "GET";
            #   Name = "NixOS Options";
            #   URLTemplate = "https://search.nixos.org/options?from=0&size=200&sort=relevance&type=packages&query={searchTerms}";
            # }
            {
              Alias = "@sx";
              Description = "homelab";
              IconURL = "";
              Method = "GET";
              Name = "homelab";
              URLTemplate = "https://search.andi242.dedyn.io/search?q={searchTerms}";
            }
          ];
        };
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
              url = "https://search.nixos.org";
            }
          ];
        };
        isDefault = true;
        name = "ad";
      };
    };
  };
}
