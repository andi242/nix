{ inputs, pkgs, ... }:
let
  bla = "blubb";
in
{
  nixpkgs.overlays = [
    # ##################
    # google drive enablement for gnome
    # (final: prev: {
    #   gnome = prev.gnome.overrideScope (gfinal: gprev: {
    #     gvfs = gprev.gvfs.override {
    #       googleSupport = true;
    #       gnomeSupport = true;
    #     };
    #   });
    # })
    # ##################
    # (final: prev: {
    #   lact = final.callPackage "${lact-src}/pkgs/by-name/la/lact/package.nix" {
    #     hwdata = final.callPackage "${lact-src}/pkgs/by-name/hw/hwdata/package.nix" { };
    #   };
    # })
    # (self: super: {
    #   openrgb = (super.openrgb.override { }).overrideAttrs (oldAttrs: {
    #     src = pkgs.fetchFromGitLab {
    #       owner = "CalcProgrammer1";
    #       repo = "OpenRGB";
    #       rev = "release_candidate_1.0rc1";
    #       sha256 = "sha256-jKAKdja2Q8FldgnRqOdFSnr1XHCC8eC6WeIUv83e7x4=";
    #     };
    #     postPatch = ''
    #       patchShebangs scripts/build-udev-rules.sh
    #       substituteInPlace scripts/build-udev-rules.sh \
    #         --replace-fail /usr/bin/env "${pkgs.coreutils}/bin/env"
    #     '';
    #   });
    # })
  ];
}
