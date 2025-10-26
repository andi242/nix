{ pkgs, config, lib, ... }:
let
  cfg = config.sysconf;
  thisOption = lib.removeSuffix ".nix" "${builtins.baseNameOf (__curPos.file)}";
in {
  options.sysconf = {
    ${thisOption}.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
  config = lib.mkIf cfg.${thisOption}.enable {
    virtualisation.libvirtd = {
      enable = true;
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

    programs = { virt-manager.enable = true; };
  };
}
