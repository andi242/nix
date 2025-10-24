{ callPackage, qt6Packages, pkgsi686Linux, ... }:
{
  obs-retro-effects = callPackage ./obs-retro-effects { };
  obs-noise = callPackage ./obs-noise { };
  obs-source-dock = qt6Packages.callPackage ./obs-source-dock { };
  obs-stroke-glow-shadow = callPackage ./obs-stroke-glow-shadow { };
}
