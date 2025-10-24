{ pkgs, config, lib, ... }:
let
  cfg = config.sysconf;
  thisOption = lib.removeSuffix ".nix" "${builtins.baseNameOf (__curPos.file)}";
in {
  options = {
    sysconf = {
      ${thisOption}.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };
  config = lib.mkIf cfg.${thisOption}.enable {
    programs.neovim = {
      defaultEditor = true;
      enable = true;
      viAlias = true;
      vimAlias = true;
      withRuby = false;
    };
    environment.systemPackages = with pkgs; [
      nodejs # neovim plugins req.
      ripgrep # for neovim telescope
      imagemagick # image preview in vim
      ghostscript # doc converter
    ];
  };
}
