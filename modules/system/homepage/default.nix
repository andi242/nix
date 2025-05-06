{ pkgs, inputs, pkgs-unstable, ... }:
let
  serverUrl = "andi242.dedyn.io";
in
{
  environment.systemPackages = with pkgs; [
    homepage-dashboard
  ];
  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    listenPort = 8082;
    # allowedHosts = "*"; # for unstable
    # package = pkgs-unstable.homepage-dashboard;
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
          url = "http://search.${serverUrl}/search?q=";
          target = "_blank";
        };
      }
    ];
    services = [
      {
        "Home" = [
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
                      suffix = "left";
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
      }
      {
        "Web" = [
          {
            caddy = {
              icon = "si-caddy";
              widget = {
                type = "caddy";
                url = "http://localhost:2019";
                fields = [ "upstreams" "requests" "requests_failed" ];
              };
            };
          }
        ];
      }
    ];
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
