{ pkgs, inputs, ... }:
{
  home.username = "ad";
  home.homeDirectory = "/home/ad";
  home.stateVersion = "24.05";
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./modules/starship
    ./modules/zsh
    ./modules/obs
  ];

  home.packages = with pkgs; [
    inputs.nixvim.packages.${system}.default
  ];

  home.file = {
    # ".screenrc".source = dotfiles/screenrc;
    ".config/nvim/snippets/nix.json".source = ./modules/misc/snippets-nix.json;
  };

  home.sessionVariables = {
    FLAKE = "/home/ad/gits/nix/system";
  };
  # xdg.configFile = {
  #   "dotfiles" = {
  #     enable = true;
  #     # recursive = true;
  #     source = builtins.fetchGit "git+ssh://git@github.com/andi242/dotfiles.git"; # fetch with .ssh key
  #   };
  # };
  programs = {
    home-manager.enable = true;
  };
}
