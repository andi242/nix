{ pkgs, config, ... }:
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
  environment.systemPackages = with pkgs; [
    furmark
    (callPackage ./lact.nix { })
    steam
    mangohud
    lutris
    winetricks
    wineWowPackages.stable
    libcamera # wireplumber might want it
    mesa
  ];
  # for 0.7.0:
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
