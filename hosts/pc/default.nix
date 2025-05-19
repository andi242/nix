{ pkgs, config, pkgs-unstable, ... }:
{
  imports = [
    ./hardware.nix
    ./libvirt.nix
    ./configuration.nix
    ../../modules/system
    ../../modules/gnome
  ];
  programs.nix-ld.enable = true; # for precompiled binaries
  programs = {
    steam.enable = true;
    # programs.steam.gamescopeSession.enable = true; #optional for scaling
    gamemode.enable = true;
    evolution.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };

  environment.systemPackages = (with pkgs; [
    lact
    # furmark
    steam
    mangohud
    lutris
    winetricks
    wineWowPackages.stable
    libcamera # wireplumber might want it
  ]) ++
  (with pkgs-unstable;
  [
    # add
  ]);

  systemd.services.lact = {
    description = "LACT Daemon";
    after = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.lact}/bin/lact daemon";
    };
    enable = true;
  };
}
