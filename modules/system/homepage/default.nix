{ pkgs, inputs, pkgs-unstable, ... }:
let
  serverUrl = "192.168.122.241";
in
{
  environment.systemPackages = with pkgs; [
    homepage-dashboard
  ];
  # environment.etc = {
  #   "homepage-dashboard/services.yaml".source = ./services.yaml;
  # };

  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    listenPort = 8082;
    # https://gethomepage.dev/configs/
    widgets = [
      {
        resources = {
          cpu = true;
          disk = "/";
          memory = true;
        };
      }
      {
        search = {
          provider = "custom";
          url = "http://search.k3s.lan/search?q=";
          target = "_blank";
        };
      }
    ];
    services = [{
      Home = [
        {
          blocky = {
            description = "ad blocker";
            icon = "si-adblock";
            widget = {
              type = "customapi";
              url = "http://${serverUrl}:4000/api/blocking/status";
              method = "GET";
              headers = "Content-Type: application/json";
              display = "list";
              mappings = [
                {
                  field = "enabled";
                  label = "Status";
                  format = "text";
                  additionalField = {
                    field = "autoEnableInSec";
                    label = "disabled for";
                    format = "duration";
                    suffix = "s left";
                  };
                  remap = [
                    { value = true; to = "enabled"; }
                    { value = false; to = "disabled"; }
                  ];
                }
              ];
            };
          };
        }
      ];
    }];
    bookmarks = [
      {
        Tools = [
          { "disable Blocky 1m" = [{ abbr = "BLK"; href = "http://${serverUrl}:4000/api/blocking/disable?duration=60s"; }]; }
          { "disable Blocky 5m" = [{ abbr = "BLK"; href = "http://${serverUrl}:4000/api/blocking/disable?duration=300s"; }]; }
          { "enable Blocky" = [{ abbr = "BLK"; href = "http://${serverUrl}:4000/api/blocking/enable"; }]; }
        ];
      }
      {
        Developer = [
          {
            Github = [
              {
                abbr = "GH";
                href = "https://github.com/";
              }
            ];
          }
        ];
      }
      {
        Entertainment = [
          {
            Twitch = [
              {
                abbr = "TW";
                href = "https://twitch.com/";
              }
            ];
          }
          {
            YouTube = [
              {
                abbr = "YT";
                href = "https://youtube.com/";
              }
            ];
          }

          {
            YouTubeMusic = [
              {
                abbr = "YTM";
                href = "https://music.youtube.com/";
              }
            ];
          }
        ];
      }
    ];
  };
}
