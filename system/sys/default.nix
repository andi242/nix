{ config, pkgs, ... } : 
let
  aliases = {
    cat = "bat --paging=never";
  };
in 
  {
  # some config
  nixpkgs.config.allowUnfree = true;
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    shellAliases = aliases;
  };
  security.sudo.extraRules = [
    { groups = [ "wheel" ]; commands = [ {command = "ALL" ; options = [ "NOPASSWD" ]; } ]; }
  ];
  # system packages 
  environment.systemPackages = with pkgs; [
    unzip
    podman
    fontconfig
    git
    wget
    curl
    unzip
    zsh
    home-manager
    gcc
    bat
    bitwarden-cli
  ];
  imports = [
    ./nvim.nix
    ./fonts.nix
    ./flatpak.nix
  ];

}
