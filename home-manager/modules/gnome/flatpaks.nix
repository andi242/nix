{ config, pkgs, lib, ... }:

##
# does not work rn
##

let
  grep = pkgs.gnugrep;

  # 1. Declare the Flatpaks you *want* on your system
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
    flatpakManagement = lib.hm.dag.entryAfter [ "installPackages" ] ''
      # 2. Ensure the Flathub repo is added
      ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub \
        https://flathub.org/repo/flathub.flatpakrepo

      # 3. Get currently installed Flatpaks
      installedFlatpaks=$(${pkgs.flatpak}/bin/flatpak list --app --columns=application)

      # 4. Remove any Flatpaks that are NOT in the desired list
      for installed in $installedFlatpaks; do
        if ! echo ${toString desiredFlatpaks} | ${grep}/bin/grep -q $installed; then
          echo "Removing $installed because it's not in the desiredFlatpaks list."
          ${pkgs.flatpak}/bin/flatpak uninstall -y --noninteractive $installed
        fi
      done

      # 5. Install or re-install the Flatpaks you DO want
      for app in ${toString desiredFlatpaks}; do
        echo "Ensuring $app is installed."
        ${pkgs.flatpak}/bin/flatpak install -y flathub $app
      done

      # 6. Update all installed Flatpaks
      ${pkgs.flatpak}/bin/flatpak update -y
    '';
  };
}
