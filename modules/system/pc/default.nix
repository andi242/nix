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
  # environment.systemPackages = with pkgs; [
  environment.systemPackages = (with pkgs; [
    (callPackage ./lact-git.nix { })
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
  systemd.services.lactd = {
    description = "AMDGPU Control Daemon";
    enable = true;
    serviceConfig = {
      # this path because we don't use pkgs.lact
      ExecStart = "/run/current-system/sw/bin/lact daemon";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
