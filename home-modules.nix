{ username, ... }: {
  imports = map (f: ./home/${f}) (builtins.attrNames (builtins.readDir ./home));
  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "24.11";
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      GTK_THEME_VARIANT = "dark";
    };
  };
  programs = { home-manager.enable = true; };
  userconf = {
    shell.enable = true;
    git.enable = true;
  };
}

