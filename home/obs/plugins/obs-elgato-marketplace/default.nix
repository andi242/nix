{ lib, stdenv, fetchurl, gzip, msitools }:

stdenv.mkDerivation rec {
  pname = "obs-elgato-marketplace-connect";
  version = "1.0.1.53";
  projUrl = "https://www.elgato.com/de/de/s/marketplace-connect-for-obs";

  src = fetchurl {
    url = "https://edge.elgato.com/egc/windows/marketplaceconnect/ElgatoMarketplaceConnectSetup_1.0.1.53.msi";
    hash = "sha256-kaFFwS90oVIDvQKkhCjKfTk3NFcj8FaOtHeEXbteyIY=";
  };
  dontBuild = true;
  nativeBuildInputs = [
    msitools
  ];

  unpackPhase = ''
    msiextract ${src}
    mkdir -p "$out/lib/obs-plugins"
    mkdir -p "$out/share/obs/obs-plugins"
    mv obs-studio/obs-plugins/64bit/* "$out/lib/obs-plugins/"
    mv obs-studio/data/* "$out/share/obs/"
  '';

  meta = with lib; {
    description = "A plug-in for exporting scene collections, no marketplace connect.";
    homepage = projUrl;
    license = licenses.gpl2Only;
    maintainers = [ "andi242" ];
    mainProgram = pname;
    platforms = platforms.linux;
  };
}
