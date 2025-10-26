# { lib, stdenv, fetchurl, fetchFromGitHub, gzip }:
{ lib, stdenv, obs-studio, fetchFromGitHub, cmake }:

stdenv.mkDerivation rec {
  pname = "obs-stroke-glow-shadow";
  version = "1.5.2";
  projUrl = "https://github.com/FiniteSingularity/obs-stroke-glow-shadow";

  src = fetchFromGitHub {
    owner = "FiniteSingularity";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-+2hb4u+6UG7IV9pAvPjp4wvDYhYnxe98U5QQjUcdD/k=";
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
