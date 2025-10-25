{ pkgs, inputs, config, ... }: {
  imports = [ ./home-modules.nix ];
  userconf = {
    ghostty.enable = true;
    librewolf.enable = true;
    shell.enable = true;
    git.enable = true;
    services.enable = true;
    gnome-settings.enable = true;
    gnome-settings.dconf.enable = false;
    kitty.enable = false;
  };
  programs = { home-manager.enable = true; };
}

