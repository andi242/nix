{ pkgs, callPackage, qt6Packages, pkgsi686Linux, ... }:
{
  # obs- = callPackage ./obs-.nix { };
  obs-retro-effects = callPackage ./obs-retro-effects.nix { };
}
