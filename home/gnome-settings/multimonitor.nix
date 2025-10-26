{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "gnome-shell-extension-multi-monitors-add-on";
  version = "48.0";

  src = fetchFromGitHub {
    owner = "Lemagex";
    repo = "multi-monitors-add-on";
    rev = "v${version}";
    hash = "sha256-f5i14gTwAGaak7XnJaNEkFtc2FoqO4ICMqoLYN9dQEw=";
  };
  installPhase = ''
    mkdir -p "$out/share/gnome-shell/extensions"
    cp -a multi-monitors-add-on@spin83 "$out/share/gnome-shell/extensions"
  '';

  passthru = {
    extensionUuid = "multi-monitors-add-on@spin83";
    extensionPortalSlug = "multi-monitors-add-on";
  };

  meta = with lib; {
    description = "Add multiple monitors overview and panel for gnome-shell.";
    license = licenses.gpl2Plus;
    maintainers = "andi242";
    homepage = "https://github.com/Lemagex/multi-monitors-add-on";
  };
}
