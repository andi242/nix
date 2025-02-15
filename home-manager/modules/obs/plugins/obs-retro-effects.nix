{ lib
, stdenv
, fetchFromGitHub
, obs-studio
, cmake
,
}:
stdenv.mkDerivation rec {
  pname = "obs-retro-effects";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "FiniteSingularity";
    repo = "obs-retro-effects";
    rev = "refs/tags/${version}";
    hash = "sha256-+dg5ySleMb9abT9kIM7HvRSRx9V08B9XPjfoAVe+tWY=";
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
  '';

  meta = with lib; {
    description = "A collection of OBS filters to give your stream that retro feel.";
    homepage = "https://github.com/FiniteSingularity/obs-retro-effects";
    license = licenses.gpl2Only;
    maintainers = [ "andi242" ];
    mainProgram = "obs-retro-effects";
    platforms = platforms.linux;
  };
}
