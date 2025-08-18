{ pkgs, ... }:
{
  imports = [
    ./hardware.nix
    ./configuration.nix
    ../../modules/system
    # ../../modules/gnome
    ../../modules/kde
  ];
}
