{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ad";
  home.homeDirectory = "/home/ad";
  nixpkgs.config.allowUnfree = true;
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.
  imports = [
    # ./modules/starship
    # ./modules/zsh
    # ./modules/nvim
  ];
  # The home.packages option allows you to install Nix packages into your
  # environment.
  # fonts.fontconfig.enable = true;
  # fonts.fontconfig = {
  #   enable = true;
  #   defaultFonts = {
  #     emoji = ["GeistMono"];
  #     monospace = ["GeistMono"];
  #   };
  # };
  
  home.packages = with pkgs; [
    discord
    stow
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".config/shell.inc".text = builtins.readFile ./modules/zsh/shell.inc;
    # ".config/home-manager/flake.nix".text = builtins.readFile ./flake.nix;
    # ".config/waybar/config.jsonc".text = builtins.readFile ./modules/hyprland/waybar/waybar.jsonc;
    # ".config/waybar/mocha.css".text = builtins.readFile ./modules/hyprland/waybar/mocha.css;
    # ".config/waybar/style.css".text = builtins.readFile ./modules/hyprland/waybar/style.css;
    # ".config/hypr/hyprland.conf".text = builtins.readFile ./modules/hyprland/hyprland.conf;
    # ".config/home-manager/home.nix".text = builtins.readFile ./home.nix;
    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ad/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
    VARVAR = "bla";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
