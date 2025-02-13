{ config, pkgs, ... }:
{
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      advanced-scene-switcher
      obs-composite-blur
      obs-gradient-source
      obs-gstreamer
      obs-move-transition
      obs-shaderfilter
      obs-source-clone
      waveform
    ];
  };
}
