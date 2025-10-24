{ pkgs, inputs, config, ... }: {
  imports = [ ./home-modules.nix ];
  userconf = {
    ghostty.enable = true;
    librewolf.enable = true;
    shell.enable = true;
    git.enable = true;
    services.enable = true;
    gnome-settings.enable = true;
    kitty.enable = false;
  };
  programs = { home-manager.enable = true; };
}

