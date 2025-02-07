{ config, pkgs, ... }:

{
  home.username = "ad";
  home.homeDirectory = "/home/ad";
  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "24.05";

  imports = [
    # ./modules/starship
    # ./modules/zsh
    # ./modules/nvim
  ];

  home.packages = with pkgs; [
    discord
    stow
    nvtopPackages.amd
    (pkgs.writeShellScriptBin "nix-clean" ''
       echo "cleaning HM generations"
       home-manager expire-generations -10
       echo "collecting nix garbage"
       sudo nix-store --gc
       sudo nix-collect-garbage --delete-older-than 10d
    '')
    (pkgs.writeShellScriptBin "nix-apply" ''
       if [ -z "$1" ]; then
         echo 'path to flake not set!'
         exit 1
       fi
       echo building $1
       sudo nixos-rebuild switch --upgrade --flake $1
    '')
    (pkgs.writeShellScriptBin "ha-apply" ''
       if [ -z "$1" ]; then
         echo 'path to flake not set!'
         exit 1
       fi
       echo building $1
       home-manager switch --flake $1
    '')
  ];

  home.file = {
    # ".screenrc".source = dotfiles/screenrc;
  };

   home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
