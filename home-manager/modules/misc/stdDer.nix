{ stdenv, ... }:
stdenv.mkDerivation {
  pname = "bla";
  version = "1";

  dontBuild = true;
  src = "script";

  unpackPhase = ''
    echo "echo bla" > script
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/bla
    chmod +x $out/bin/bla
  '';

  # propagateBuildInputs = [ runTimePackage ];

  meta = {
    description = "bla";
    homepage = "blubb";
    # license = lib.licenses.;
    # maintainers = with lib.maintainers; [  ];
  };
}
