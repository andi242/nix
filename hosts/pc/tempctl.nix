{ lib, pkgs, config, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    lm_sensors
    # coolercontrol.coolercontrol-gui # just localhost it
    coolercontrol.coolercontrold
  ];

  programs.coolercontrol.enable = false;
}
