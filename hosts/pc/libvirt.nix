{ pkgs, ... }:
{
  virtualisation.libvirtd = {
    enable = false;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          pkgs.OVMFFull.fd
          # (pkgs.OVMF.override {
          #   secureBoot = true;
          #   tpmSupport = true;
          # }).fd
        ];
      };
    };
  };

  programs = {
    virt-manager.enable = false;
  };
}
