{ pkgs, config, lib, ... }:
let
  cfg = config.userconf;
  thisOption = lib.removeSuffix ".nix" "${builtins.baseNameOf (__curPos.file)}";
  aliases = { vc = "vi ~/gits/nix"; };
  # dotspath = builtins.toString inputs.nix-dotfiles;
in {
  options.userconf = {
    ${thisOption}.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
  config = lib.mkIf cfg.${thisOption}.enable {
    home.packages = with pkgs; [ starship ];
    programs.starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        add_newline = false;
        # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.starship.settings
      };
    };
    programs = {
      fish = {
        enable = true;
        shellAliases = aliases;
        shellInit = ''
          set -g fish_greeting
          source (${pkgs.starship}/bin/starship init fish --print-full-init | psub)
          function gall -a msg
            echo "commit message: $msg"
            git pull && git add --all && git commit -m $msg && git push && git log --oneline --decorate -n5
          end
        '';
      };
    };
  };
}
