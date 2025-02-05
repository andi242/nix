{ config, pkgs, lib, ... }:

let
  grep = pkgs.gnugrep;
  desiredFlatpaks = [
    "org.mozilla.firefox"
    "org.mozilla.Thunderbird"
    "com.github.tchx84.Flatseal"
    "io.github.ungoogled_software.ungoogled_chromium"
    "org.virt_manager.virt-manager"
    "com.core447.StreamController"
  ];
in
{
  home.activation = {
    flatpakManagement = lib.hm.dag.entryAfter ["installPackages"] ''
      ls ${pkgs.bash}/bin
    '';
  };
}
