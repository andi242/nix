{ pkgs, ... }:
{
  imports = [
    ./hardware.nix
    ./locale.nix
  ];
  environment.systemPackages = [
    (pkgs.callPackage ./snd-kernel.nix { kernel = pkgs.linux_6_12; })
  ];
}
