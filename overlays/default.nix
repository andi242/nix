{ inputs, ... }:
let
  bla = "blubb";
in
{
  nixpkgs.overlays = [
    (final: prev: {
      python313Packages.textual = prev.python313Packages.textual.overrideAttrs (old: {
        # version = "3.7.1";
        src = fetchFromGitHub {
          owner = "Textualize";
          repo = "textual";
          tag = "v3.7.1";
          # tag = "v${version}";
          hash = "sha256-ceA4Mv/oq4tZRC8rY6xkpuAcS/f3GXcY891EoOCES/M=";
        };
      });
    })
  ];
}
