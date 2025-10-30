{ pkgs, config, lib, ... }:
let
  cfg = config.sysconf;
  thisOption = lib.removeSuffix ".nix" "${builtins.baseNameOf (__curPos.file)}";
in {
  config = lib.mkIf cfg.${thisOption}.enable {
    fonts.fontconfig.useEmbeddedBitmaps = true;
    fonts.packages = with pkgs; [
      nerd-fonts.geist-mono
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
      nerd-fonts.adwaita-mono
      nerd-fonts.jetbrains-mono
    ];
  };
}
