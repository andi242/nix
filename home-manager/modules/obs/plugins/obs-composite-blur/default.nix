{ lib
, stdenv
, fetchFromGitHub
, obs-studio
, cmake
,
}:
stdenv.mkDerivation rec {
  pname = "obs-composite-blur";
  version = "1.5.0";

  src = fetchFromGitHub {
    owner = "FiniteSingularity";
    repo = "obs-composite-blur";
    rev = "refs/tags/v${version}";
    hash = "sha256-D9vGXCrmQ8IDRmL8qZ1ZBiOz9AjhKm45W37zC16kRCk=";
  };

  buildInputs = [
    obs-studio
  ];

  nativeBuildInputs = [
    cmake
  ];

  postInstall = ''
    rm -rf "$out/share"
    mkdir -p "$out/share/obs"
    mv "$out/data/obs-plugins" "$out/share/obs"
    rm -rf "$out/obs-plugins" "$out/data"
    ls -lahR $out/share/obs/obs-plugins
  '';

  meta = with lib; {
    description = "A plug-in for noise generation and noise effects for OBS.";
    homepage = "https://github.com/FiniteSingularity/obs-composite-blur";
    license = licenses.gpl2Only;
    maintainers = [ "andi242" ];
    mainProgram = pname;
    platforms = platforms.linux;
  };
}
