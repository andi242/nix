# { pkgs, inputs, config, ... }: 
{ username, ...}:
{
  imports = [ 
    # ./home-modules.nix 
    (import ./home-modules.nix { inherit username; }) 
  ];
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

