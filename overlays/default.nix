{ inputs, ... }:
let
  sc-src = inputs.sc-pr;
in
{
  nixpkgs.overlays = [
    ######### lact 0.7.3 PR until 25.05
    # https://github.com/NixOS/nixpkgs/pull/374771
    # (final: prev: {
    #   lact = final.callPackage "${lact-src}/pkgs/by-name/la/lact/package.nix" {
    #     hwdata = final.callPackage "${lact-src}/pkgs/by-name/hw/hwdata/package.nix" { };
    #   };
    # })
    #########
    # (final: prev: {
    #   streamcontroller = final.callPackage "${sc-src}/pkgs/by-name/st/streamcontroller/package.nix" {
    #     python3Packages = final.callPackage "${sc-src}/pkgs/top-level/python-packages.nix" { };
    #   };
    # })

  ];
}
