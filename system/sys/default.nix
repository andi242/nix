{ config, pkgs, inputs, ... } : 
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
  
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  programs.zsh = {
    enable = true;
    shellAliases = aliases;
  };
  services.flatpak.enable = true;

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
    openssl
    neovim
  ];
  fonts.fontconfig.useEmbeddedBitmaps = true;
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "GeistMono" ]; })
    # in nixos-unstable/25.05:
    # nerd-fonts.geist-mono
    
  ];
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
  imports = [
  ];
  # system.autoUpgrade = {
  #   enable = true;
  #   flake = inputs.self.outPath;
  #   flags = [
  #     "--update-input"
  #     "nixpkgs"
  #     "-L" # print build logs
  #   ];
  #   dates = "02:00";
  #   randomizedDelaySec = "45min";
  # };
  users.users.ad = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd"];
    uid = 1000;
  };
  security.sudo.extraRules = [
    { groups = [ "wheel" ]; commands = [ {command = "ALL" ; options = [ "NOPASSWD" ]; } ]; }
  ];
}
