{ config, pkgs, lib, ... }:

let
  grep = pkgs.gnugrep;

in
{
  home.activation = {
    flatpakManagement = lib.hm.dag.entryAfter ["installPackages"] ''
      ls ${pkgs.bash}/bin
    '';
  };
}
