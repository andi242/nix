{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ad";
  home.homeDirectory = "/home/ad";
  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "24.05"; # Please read the comment before changing.

  imports = [
    # ./modules/starship
    # ./modules/zsh
    # ./modules/nvim
  ];

   home.packages = with pkgs; [
    discord
    stow
    nvtopPackages.amd
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    (pkgs.writeShellScriptBin "nix-clean" ''
       echo "cleaning HM generations"
       home-manager expire-generations -10
       echo "collecting nix garbage"
       sudo nix-store --gc
       sudo nix-collect-garbage --delete-older-than 10d
    '')
   # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

   home.file = {
    # ".screenrc".source = dotfiles/screenrc;
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

   home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
