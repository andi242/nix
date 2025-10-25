{ pkgs, ... }:
{
  imports = [
    ./hardware.nix
    ./configuration.nix
  ];
  sysconf = {
    fish.enable = true;
    flatpak.enable = true;
    fonts.enable = true;
    gnome.enable = true;
    nh.enable = true;
    nvim.enable = true;
    office.enable = true;
  };
  users.users.ad = {
    isNormalUser = true;
    password = "12345"; # VM testing
    extraGroups = [ "wheel" "libvirtd" "audio" ];
    uid = 1000;
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG2bj+JgXVQ+9r8UA0zpBn2cx1DhffMIJXb3tF8ClSm1 ad" ];
  };
  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "24.11";
}
