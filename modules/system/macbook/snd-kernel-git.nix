# https://blog.prag.dev/building-kernel-modules-on-nixos
# https://github.com/leifliddy/macbook12-audio-driver
# https://nixos.wiki/wiki/Linux_kernel#Out-of-tree_kernel_modules
{ stdenv
, fetchFromGitHub
, kernel
, kmod
, lib
}:

stdenv.mkDerivation rec {
  name = "macbook12-audio-driver";
  version = "6.12";

  src = fetchFromGitHub {
    owner = "leifliddy";
    repo = "macbook12-audio-driver";
    rev = "8ad134af5e70460feb849641d0a2e91cf6c10e45";
    hash = "sha256-Hq8q2o7rVWo8BZL5FkQ5tUnFsSteVCFQ4PM/xRm2ag4=";
  };

  hardeningDisable = [ "pic" "format" ];
  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = [
    "KERNELRELEASE=${kernel.modDirVersion}"
    "KERNEL_DIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "INSTALL_MOD_PATH=$(out)"
  ];

  unpackPhase = ''
    hda_dir=build/hda
    mkdir -p $hda_dir
    cp -r ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build/source/sound/pci/hda/* $hda_dir
    cp $src/patch_cirrus/{*.h,*.c,Makefile} $hda_dir
    ls -lah $hda_dir
    sed -i 's/snd_pci_quirk/hda_quirk/' $hda_dir/patch_cirrus.c
    sed -i 's/SND_PCI_QUIRK\b/HDA_CODEC_QUIRK/' $hda_dir/patch_cirrus.c
  '';
  buildPhase = ''
    make -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build modules "M=$(pwd -P)/build/hda"
  '';
  installPhase = ''
    mkdir -p $out/lib/modules/${kernel.modDirVersion}
    cp build/hda/snd-hda-codec-cirrus.ko $out/lib/modules/${kernel.modDirVersion}/
  '';
}
