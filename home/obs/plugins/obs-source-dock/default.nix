{ lib
, stdenv
, fetchFromGitHub
, obs-studio
, cmake
, qt6
}:
stdenv.mkDerivation rec {
  pname = "obs-source-dock";
  version = "0.4.1";

  src = fetchFromGitHub {
    owner = "exeldro";
    repo = "obs-source-dock";
    rev = "refs/tags/${version}";
    hash = "sha256-Oy4RamaGru+/HGpKRDu8GWHcxqWVoV90oqPZYlU/vec=";
  };

  buildInputs = [
    obs-studio
  ];

  nativeBuildInputs = [
    cmake
    qt6.qtbase
    qt6.wrapQtAppsHook
  ];

  postInstall = ''
    rm -rf "$out/share"
    mkdir -p "$out/share/obs"
    mv "$out/data/obs-plugins" "$out/share/obs"
    rm -rf "$out/obs-plugins" "$out/data"
    ls -lahR $out/share/obs/obs-plugins
  '';

  meta = with lib; {
    description = "Plugin for OBS Studio allowing you to create a Dock for a source, which lets you interact, see audio levels, change volume and control media.";
    homepage = "https://github.com/exeldro/obs-source-dock";
    license = licenses.gpl2Only;
    maintainers = [ "andi242" ];
    mainProgram = "obs-source-dock";
    platforms = platforms.linux;
  };
}
