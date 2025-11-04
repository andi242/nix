{ pkgs, config, lib, inputs, ... }:
let
  cfg = config.sysconf;
  thisOption = lib.removeSuffix ".nix" "${builtins.baseNameOf (__curPos.file)}";
in {
  config = lib.mkIf cfg.${thisOption}.enable {
    programs.neovim = {
      package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
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
      # hide that desktop icon
      (lib.hiPrio (pkgs.runCommand "nvim.desktop-hide" { } ''
        mkdir -p "$out/share/applications"
        cat "${config.programs.neovim.finalPackage}/share/applications/nvim.desktop" > "$out/share/applications/nvim.desktop"
        echo "Hidden=1" >> "$out/share/applications/nvim.desktop"
      ''))
    ];
  };
}
