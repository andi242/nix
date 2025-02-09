{ pkgs, inputs, ... }:
{
  home.username = "ad";
  home.homeDirectory = "/home/ad";
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "24.05";

  imports = [
    # ./modules/nvim
    # ./modules/starship
    # ./modules/zsh
  ];

  home.packages = with pkgs; [
    discord
    stow
    nvtopPackages.amd
    inputs.nixvim.packages.${system}.default
    # use nh tool instead
    # (pkgs.writeShellScriptBin "nix-clean" ''
    #   echo "cleaning HM generations"
    #   home-manager expire-generations -10
    #   echo "collecting nix garbage"
    #   sudo nix-store --gc
    #   sudo nix-collect-garbage --delete-older-than 10d
    # '')
  ];

  home.file = {
    # ".screenrc".source = dotfiles/screenrc;
  };

  home.sessionVariables = {
    FLAKE = "/home/ad/gits/nix/system";
  };

  programs = {
    home-manager.enable = true;
  };
}
