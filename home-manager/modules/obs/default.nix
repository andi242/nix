{ pkgs, ... }:

#   # nix-build -E 'with import <nixpkgs>  {}; callPackage ./obs-composite-blur {}'
{
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
      obs-vaapi
      obs-vkcapture
      obs-shaderfilter
      obs-source-switcher
      advanced-scene-switcher
      obs-gradient-source
      obs-gstreamer
      obs-move-transition
      obs-shaderfilter
      obs-source-clone
      obs-source-record
      waveform
      # built plugins
      (pkgs.callPackage ./plugins/obs-composite-blur { })
      (pkgs.callPackage ./plugins/obs-retro-effects { })
      (pkgs.callPackage ./plugins/obs-stroke-glow-shadow { })
      (pkgs.callPackage ./plugins/obs-noise { })
      (pkgs.callPackage ./plugins/obs-source-dock { })
      (pkgs.callPackage ./plugins/obs-advanced-masks { })
    ];
  };
}
