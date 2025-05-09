{ inputs, config, lib, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  imports = [ ];

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=30s
  '';

  networking = {
    hostName = "nixos-git";
    nameservers = [ "192.168.1.10" ];
  };

  security.rtkit.enable = true;
  services.resolved = {
    enable = true;
    fallbackDns = [ ];
    dnsovertls = "false";
    dnssec = "false";
  };
  services = {
    openssh.enable = true;
  };
  system.stateVersion = "24.11";
}
