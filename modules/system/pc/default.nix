{ pkgs, config, pkgs-unstable, ... }:
{
  imports = [
    ./hardware.nix
    ./libvirt.nix
    ./locale.nix
  ];
  programs = {
    steam.enable = true;
    # programs.steam.gamescopeSession.enable = true; #optional for scaling
    gamemode.enable = true;
    evolution.enable = true;
  };
  environment.systemPackages = (with pkgs; [
    # (callPackage ./lact-git.nix { })
    lact
    # furmark
    steam
    mangohud
    lutris
    winetricks
    wineWowPackages.stable
    libcamera # wireplumber might want it
    vulkan-tools
  ]) ++
  (with pkgs-unstable;
  [
    # add
    mesa
  ]);

  # for 0.7.3:
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
