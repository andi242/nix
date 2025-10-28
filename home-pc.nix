# { pkgs, inputs, config, ... }:
{ username, ... }: {
  imports = [
    # ./home-modules.nix 
    (import ./home-modules.nix { inherit username; })
  ];
  userconf = {
    ghostty.enable = true;
    librewolf.enable = true;
    services = { flatpak-update.enable = true; };
    gnome-settings = {
      enable = true;
      dconf-settings.enable = false;
    };
  };
}

