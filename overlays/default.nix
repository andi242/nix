{ config, pkgs, lib, ... }:
{
  nixpkgs.overlays = [
    ######### lact 0.7.3 PR
    # https://github.com/NixOS/nixpkgs/pull/374771
    (final: prev: {
      lact = final.callPackage "${lact-pr}/pkgs/by-name/la/lact/package.nix" {
        hwdata = final.callPackage "${lact-pr}/pkgs/by-name/hw/hwdata/package.nix" { };
      };

      # streamcontroller = final.callPackage "${pkgs-unstable}/pkgs/by-name/st/streamcontroller/package.nix";
    })
    #########
  ];
}
