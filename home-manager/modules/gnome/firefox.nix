{ pkgs, ... }:

{
  home.packages = with pkgs; [
    firefox
  ];

  programs.firefox = {
    enable = true;
    profiles.ad = {
      settings = {
        extensions.AutoDisableScopes = 0;
        "browser.newtabpage.pinned" = [{
          title = "NixOS";
          url = "https://nixos.org";
        }];
      };
      isDefault = true;
      name = "ad";
    };
  };
}
