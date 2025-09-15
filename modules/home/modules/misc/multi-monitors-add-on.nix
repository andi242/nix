{ lib
, stdenv
, fetchFromGitHub
, glib
, gettext
, replaceVars
, gnome-menus
,
}:

stdenv.mkDerivation rec {
  pname = "gnome-shell-extension-multi-monitors-add-on";
  version = "48";

  src = fetchFromGitHub {
    owner = "Lemagex";
    repo = "multi-monitors-add-on";
    rev = "v${version}";
    hash = "";
  };

  patches = [
  ];

  buildInputs = [
    glib
    gettext
  ];

  makeFlags = [ "INSTALLBASE=${placeholder "out"}/share/gnome-shell/extensions" ];

  passthru = {
    extensionUuid = "multi-monitors-add-on@spin83";
    extensionPortalSlug = "multi-monitors-add-on";
  };

  meta = with lib; {
    description = "Application menu for GNOME Shell, designed to provide a more traditional user experience and workflow";
    license = licenses.gpl2Plus;
    maintainers = "andi242";
    homepage = "https://github.com/Lemagex/multi-monitors-add-on";
  };
}
