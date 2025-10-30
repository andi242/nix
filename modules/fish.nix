{ pkgs, config, lib, ... }:
let
  cfg = config.sysconf;
  # thisOption = builtins.baseNameOf (__curPos.file);
  thisOption = lib.removeSuffix ".nix" "${builtins.baseNameOf (__curPos.file)}";
  aliases = {
    cat = "bat -pp";
    dff = "${pkgs.duf}/bin/duf --hide-fs tmpfs,devtmpfs,efivarfs --hide-mp '/nix/store' --output mountpoint,avail,used,usage --theme ansi";
    d1 = "du -h -d1";
    ll = "ls -lah";
    gd = "git diff";
    gs = "git status";
    grep = "grep --color";
    mkdir = "mkdir -p";
  };
in {
  config = lib.mkIf cfg.${thisOption}.enable {
    environment.shells = with pkgs; [ fish ];
    users.defaultUserShell = pkgs.fish;
    programs = {
      fish = {
        enable = true;
        shellAliases = aliases;
      };
    };
    environment.systemPackages = with pkgs; [ duf ]; # duplicate, but because deps
  };
}
