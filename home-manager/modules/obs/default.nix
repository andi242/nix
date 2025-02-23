{ pkgs, ... }:
let
  obs-retro-effects = pkgs.callPackage ./plugins/obs-retro-effects.nix { };
  obs-noise = pkgs.callPackage ./plugins/obs-noise.nix { };
  obs-stroke-glow-shadow = pkgs.callPackage ./plugins/obs-stroke-glow-shadow.nix { };
  obs-source-dock = pkgs.callPackage ./plugins/obs-source-dock.nix { };
in
{
  # source dock
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
      obs-vaapi
      obs-vkcapture
      obs-shaderfilter
      obs-source-switcher
      advanced-scene-switcher
      obs-composite-blur
      obs-gradient-source
      obs-gstreamer
      obs-move-transition
      obs-shaderfilter
      obs-source-clone
      obs-source-record
      waveform
      # built plugins
      obs-retro-effects
      obs-stroke-glow-shadow
      obs-noise
      obs-source-dock
    ];
  };
} 
