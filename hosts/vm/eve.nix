{ lib, fetchFromGitLab, stdenv, qt6, cmake, }:

stdenv.mkDerivation {
  version = "0.0.1";
  pname = "eve-k-preview";
  # https://gitlab.com/Taroven/eve-k-preview
  src = fetchFromGitLab {
    owner = "Taroven";
    repo = "eve-k-preview";
    rev = "bba62716c82b06c9c3553184252395b7b0d4e2e4"; # main commit
    hash = "sha256-+miPM35HPeV721JmKaVpsCyZnJxZRrA6BOcX8Ev6sDQ=";
  };
  nativeBuildInputs = [ cmake qt6.full ];
  dontWrapQtApps = true;

  configurePhase = ''
    cp src/CMakeLists.txt.qt6 src/CMakeLists.txt
  '';
  buildPhase = ''
    cmake -S src -B src/build -DCMAKE_BUILD_TYPE=Release 
    cmake --build src/build -j
  '';
  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share/applications
    # we need the .sh because of some ENVs
    sed -i 's|./eve-k-preview|eve-k-bin|' eve-k-preview.sh
    cp eve-k-preview.sh $out/bin/eve-k-preview
    cp main.qml $out/bin/
    cp main-autohide.qml $out/bin/
    cp src/build/eve-k-preview $out/bin/eve-k-bin
    # !/usr/bin/env xdg-open
    cat >> $out/share/applications/eve-k-preview.desktop<< EOF
    [Desktop Entry]
    Type=Application
    Name=Eve K Preview
    Exec=$out/bin/eve-k-preview
    Icon=kamoso
    EOF
  '';

  meta = with lib; {
    description = "eve-k-preview";
    homepage = "https://gitlab.com/Taroven/eve-k-preview";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ ];
    platforms = [ "x86_64-linux" ];
  };
}
