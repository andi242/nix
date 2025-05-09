{ pkgs, inputs, pkgs-unstable, ... }:
let
  aliases = {
    cat = "bat -pp";
    dff = "${pkgs.duf}/bin/duf --hide-fs tmpfs,devtmpfs,efivarfs --hide-mp '/nix/store' --output mountpoint,avail,used,usage --theme ansi";
  };
in
{
  environment.shells = with pkgs; [ fish ];
  users.defaultUserShell = pkgs.fish;

  programs = {
    fish = {
      enable = true;
      shellAliases = aliases;
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };
  services.journald.extraConfig = ''
    SystemMaxUse=300M
  '';

  # system packages
  documentation.doc.enable = false; # no html docs
  environment.systemPackages = (with pkgs; [
    unzip
    # podman
    git
    wget
    fzf
    tree
    curl
    openssl
    nh # nix helper
    nix-output-monitor # for nh
    nvd # for nh
    nfs-utils
    usbutils
    pciutils
    sops
    btop
    jq
    neovim
    duf
    bat
  ]) ++
  (with pkgs-unstable;
  [
    # add
  ]);

  time.timeZone = "Europe/Berlin";

  imports = [
    ./locale.nix
  ];
  # garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  nix.optimise = {
    automatic = true;
    dates = [ "Mon *-*-* 00:00:00" ];
  };
  nix.settings.trusted-users = [ "ad" ];

  users.users.ad = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" "audio" ];
    uid = 1000;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG2bj+JgXVQ+9r8UA0zpBn2cx1DhffMIJXb3tF8ClSm1 ad"
    ];
  };
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG2bj+JgXVQ+9r8UA0zpBn2cx1DhffMIJXb3tF8ClSm1 ad"
  ];
  services.openssh.settings.PermitRootLogin = "prohibit-password"; # default
  security.sudo.wheelNeedsPassword = false;
}
