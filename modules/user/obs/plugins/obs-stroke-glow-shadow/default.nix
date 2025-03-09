# { lib, stdenv, fetchurl, fetchFromGitHub, gzip }:
{ lib, stdenv, obs-studio, fetchFromGitHub, cmake }:

stdenv.mkDerivation rec {
  pname = "obs-stroke-glow-shadow";
  version = "1.5.0";
  projUrl = "https://github.com/FiniteSingularity/obs-stroke-glow-shadow";
  #
  # src = fetchurl {
  #   url = "${projUrl}/releases/download/v${version}/obs-stroke-glow-shadow-${version}-ubuntu-22.04.tar.gz.zip";
  #   hash = "sha256-QPbuIPQaCAOKHCSWEEMaspE7DWY+StgRzDPakEPuZ94="; # ubuntu 22.04 hash 
  # };
  # dontBuild = true;
  # nativeBuildInputs = [
  #   gzip
  # ];
  # unpackPhase = ''
  #   rm -rf "$out/share"
  #   STRIPZIP=$(basename ${src} .zip) 
  #   cp ${src} $STRIPZIP # some weird .zip extension attached?
  #   gzip -d $STRIPZIP # get the .tar
  #   tar xf *.tar # extract the .tar
  #   mkdir -p "$out/lib/obs-plugins" # content of bin/64bits go here
  #   mkdir -p "$out/share/obs/obs-plugins/${pname}" # content of ./data go here
  #   mv ${pname}/bin/64bit/* "$out/lib/obs-plugins/"
  #   mv ${pname}/data/* "$out/share/obs/obs-plugins/${pname}"
  # '';

  src = fetchFromGitHub {
    owner = "FiniteSingularity";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-OwLMAX7zIJoDfSvbRRM5em0bLo3c5X2FYYEk8wCOUvs=";
  };
  buildInputs = [
    obs-studio
  ];
  cmakeFlags = [ "-Wno-stringop-overflow" ];
  nativeBuildInputs = [
    cmake
  ];
  postInstall = ''
    rm -rf "$out/share"
    mkdir -p "$out/share/obs"
    mv "$out/data/obs-plugins" "$out/share/obs"
    rm -rf "$out/obs-plugins" "$out/data"
  '';
  meta = with lib; {
    description = "A plug-in for noise generation and noise effects for OBS.";
    homepage = projUrl;
    license = licenses.gpl2Only;
    maintainers = [ "andi242" ];
    mainProgram = "obs-stroke-glow-shadow";
    platforms = platforms.linux;
  };
}
