{ pkgs, ... }:
let
  bkpScript = pkgs.writeShellScriptBin "bkp-home" ''
    #!/usr/bin/env bash
    set -eu
    BKP_TARGET="/home/ad/data/backup"
    BKP_FILE="bkp-''$(date +%Y-%m-%d).tar.gz"

    while read dir; do
    	if [[ ''$dir == "" ]]; then
    		echo "skip empty line"
    	else
    		echo "''$dir"
    		rsync -aAXrR --delete "$dir" "$BKP_TARGET"
    	fi
    done <backup.txt

    if [[ -f "''${BKP_TARGET}/''${BKP_FILE}" ]]; then
    	echo "removing ''${BKP_TARGET}/''${BKP_FILE}"
    	rm "''${BKP_TARGET}/''${BKP_FILE}"
    fi

    echo "compressing bkp"
    tar czf "''${BKP_TARGET}/''${BKP_FILE}" "''${BKP_TARGET}/home/ad/"
  '';

in
{
  environment.systemPackages = [ bkpScript ];
  # systemd.timers."home-bkp" = {
  #   wantedBy = [ "timers.target" ];
  #   timerConfig = {
  #     OnCalendar = "daily";
  #     Unit = "home-bkp.service";
  #   };
  # };
  #
  # systemd.services."home-bkp" = {
  #   script = ''
  #     set -eu
  #     ${pkgs.coreutils}/bin/echo "Hello World"
  #   '';
  #   serviceConfig = {
  #     Type = "oneshot";
  #     User = "ad";
  #   };
  # };
  #
}
