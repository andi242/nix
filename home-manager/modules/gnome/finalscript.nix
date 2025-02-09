{ config, pkgs, lib, ... }:

# let
#   grep = pkgs.gnugrep;
#
# in
{
  home.activation = {
    flatpakManagement = lib.hm.dag.entryAfter [ "installPackages" ] ''
      if [ $commands[flatpak] ]; then
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      fi
    '';
  };
      # ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}
