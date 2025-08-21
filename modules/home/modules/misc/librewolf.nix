{ pkgs, lib, config, ... }:

{
  # https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265
  # searnx settings
  # http://search.k3s.lan/preferences?preferences=eJx1WMuu4zYM_ZpmYzRoOwWKLrIq0G0LtHtDlmibY0n06JHE9-tL2c41FU8X1zc-kiiSOnzIWiUYKCDE2wAegrIXq_yQ1QA3lRNdLGll4Qb-Ul41udlCgtulV3fU5NsAkewdwu2Cjhe1c6DncvtT2QgXB2kkc_v7r3_-vUTVQwQV9Hj76ZJGcHCLWIRdWEK2KbYszMOjTaq7_RsyXAzhIZ0Uv14pDJdtVRvTYncVNfgEoVUWB-_49767MnflNZh233ZDv2UIS4u-TZhYwLoT-h49JhaqA1m7gduqopXefLSwIAs6bcMjpQmWeDPQK1b_koNtewpOpYR-uM0BUlouBqPqLOsAfkDPTv59UEPbEjsg_PDLH2xUB01kv05tu_ov1mhzRwPUtuu_9zGVDZIQZuGpvAmo2nY_yxWdeePGos_PZlZ6KpuIRd6r2BRL8Q4CnqfGYQgUJMZ-b_hZtg9yslfMBKMOxOOTYvPACcWskFBLK-Mk9ezQYvkTtnbsyHpK6rKeIB1Cu7mrZiSDg_CvA4PqqrW-GhCCtaVseqsCKJTL9czH1kMAps0hhDkRI-MV8jB3ZLKKxQvMb6_NZquwuYDMcYbKs0hi2iDIdQbgA4TXDcSkEkaJ3FH5xP4Uko0ZGqZioTGSj1IiW7OwxTuf5QCbgUYIZueWv4HOmouxzY3CnWKsMk7gD1Blk3cyOTXzdH4WbRx9xbkc2DGLQwmWyj0_P4VSvQkkDWDzTRpVcpxd5LQAHDLUpwefeGMwcBCXcD7WBfQTKsnOflmE4AHwY-T0IRDOHqoTlCADHYShmgHMPXICIjLMORMraGBHzFYtJbT-Z8QRs026nNMMcKDbpuRgeU6j6oIqj0PQyEEPYTuZTwyeks4sLV5lLkFnOvk25CA2Qa-ELuj5J1KW-vFBBqbiIhZ9xTiKHTjagwpLU442Snq_Bqhv2LaBK4C0r4xCCspHy0pLZljqYoJriDL8k9Kz8gKhj7EKefdwnZWAn8WB-UUJNpJZIsg8QjP4XV0xi0HeGKiGAswkVNsyMUaRyzhP86FClGHN-egct5_gOUyPoVeUfm9ZFaVz7jg73g89AhiDQq-Aw5gao0gKC5QSl1piIpKsJ9sObolYnw4XQp1jvM4LtwTiQLQyZilR4vLGl8MbP45k4XtD2x4l4prykAOOEyPqJmpeq0QMJJoWSsQMnCQdUnEbT1ZZ6irR3UmpiodFjVR544HdUr9P2BFN8R38lqn2SwEj5aDP6Ax6Dfoa5mYort54g2kp3ZdEyfZBOa7_Y9UQ_Pzly28i-E024KULP7xyVYTQV4DpjJzJt-MVu9bMNaMlQSiv7qUUCDLlbhnAyfAACCl3MtjWWs7DUym8D-jE0KJ05ZDyflYvZA51KdGyMyMHosQe9MSJPEdEExdPfnEVv2AKtX0bdNprg0-VMnLm0kmqGu9DyQxi6Z1L2tqtHfuWA3Zc2isbs3N2qdJmlfs2Uo1Z-H2oSTtPw3UgEfsX8HWzuiaLrXN87-WeKDJGx22nVm6uNd5ruezf_HB21YpWPl2Rk-9KEi3kl5Vdj9BPVLLjZz7JobRvFR0MlQLYjLmrFTQqVfod_UrVJaXFEad5L4jQW9STrIg8HbMs3iU3igrAzUC1_Vbc5TZ7uT-5Z8crB-3YyUU7fsp-477b631i7VWUNRecW5pXqkU4DeUI4QRyQUvfFcLGC_zjx1ONZG8O98r3TvGlwpB_3-kTH1UcOTHLISMLOz7Xrl6u5J5OtpyFQIqbv3LsEaSGrxEuhXywau-g5SgHLkDiRvXVrc6mEw6d-TZYqto-VqgvjmV9v7ocy_3nqG-l6-qULHnEURS55zWyO9uUagyXWvQbP4772lH4c-dAWD8vs4jXbw-ui9LdK1CTaoNO_NvgE9WC4pav6fgGEaWPI-d69epYjrRHmRNEfTx8q9ETcUD3lh4is8Qpd9mnLGZmbiZzvU25_cxvBe8TfMvQn_A5S5NFw1eBUBM2-8hddxzlxa1U_FruQvmtQhmFlnNFoY9A7-iqG3zJPJUgBsqSKkDKpBJJTMTrSW05eDoYOfj2gUAO9WhllBvU6YN85U_Htc_xPan5bLdN3V8E43GSPRalcgOTB_VQ1o5c7r1UP6VwRRG7nBzu1c4rcLZ7g08Wb3BdQdKvr5vY8QlmtpnLWryNnLa4x1lF8uG3XET0VOJctdsnp0fg5vWzGL6WlczY8o2EKZv21tXqzG6h1fiw3rLa8hkosNvuezjYvkXfU0nChVGbsAu3o5xTbv8BK8xiDA==
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
        in
        listToAttrs [
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
}
