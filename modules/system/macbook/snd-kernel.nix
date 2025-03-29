# https://blog.prag.dev/building-kernel-modules-on-nixos
# https://github.com/leifliddy/macbook12-audio-driver
{ stdenv
, nix-gitignore
, kernel
}:

stdenv.mkDerivation {
  name = "macbook12-audio-driver";
  version = "6.12";

  kernel = kernel.dev;
  kernelVersion = kernel.modDirVersion;

  src = nix-gitignore.gitignoreSource [ ] ./macbook12-audio-driver;

  unpackPhase = ''
    mkdir build
    cp -r $kernel/lib/modules/$kernelVersion/build/source/sound/pci/hda/* build
    cp $src/patch_cirrus/{*.h,*.c,Makefile} build
  '';
  buildPhase = ''
    make -C $kernel/lib/modules/$kernelVersion/build modules "M=$(pwd -P)/build"
  '';
  installPhase = ''
    mkdir -p $out/lib/modules/$kernelVersion/updates
    cp build/*.ko $out/lib/modules/$kernelVersion/updates
  '';
}
