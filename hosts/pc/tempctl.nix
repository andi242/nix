{ lib, pkgs, config, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    lm_sensors
    coolercontrol.coolercontrol-gui
    coolercontrol.coolercontrold
  ];

  programs.coolercontrol.enable = true;
}
