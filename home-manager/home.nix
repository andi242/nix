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
  ];

  home.file = {
    # ".screenrc".source = dotfiles/screenrc;
    ".config/nvim/snippets/nix.json".source = ./modules/misc/snippets-nix.json;
  };

  home.sessionVariables = {
    FLAKE = "/home/ad/gits/nix/system";
  };

  programs = {
    home-manager.enable = true;
  };
}
