{ pkgs, ... }:
{
  imports = [
    ./hardware.nix
    ./libvirt.nix
    ./configuration.nix
    ./pipewire.nix
    ./prometheus.nix
    ../../modules/system
    ../../modules/gnome
  ];
  programs.nix-ld.enable = true; # for precompiled binaries
  programs = {
    steam.enable = true;
    gamemode.enable = true;
    evolution.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };

  environment.systemPackages = with pkgs; [
    lact
    # furmark
    steam
    mangohud
    lutris
    winetricks
    wineWowPackages.stable
    libcamera # wireplumber might want it
  ];

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
