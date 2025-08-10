{ pkgs, inputs, pkgs-stable, ... }:
let
  aliases = {
    cat = "bat -pp";
    dff = "${pkgs.duf}/bin/duf --hide-fs tmpfs,devtmpfs,efivarfs --hide-mp '/nix/store' --output mountpoint,avail,used,usage --theme ansi";
    d1 = "du -h -d1";
    ll = "ls -lah";
    gd = "git diff";
    gs = "git status";
    grep = "grep --color";
    mkdir = "mkdir -p";
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
  };
  services.flatpak.enable = true;
  services.journald.extraConfig = ''
    SystemMaxUse=300M
  '';
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
  };

  # system packages
  documentation.doc.enable = false; # no html docs
  environment.systemPackages = (with pkgs; [
    unzip
    fontconfig
    git
    wget
    fzf
    tree
    curl
    gcc
    openssl
    home-manager
    nh # nix helper
    nix-output-monitor # for nh
    nvd # for nh
    usbutils
    pciutils
    sops
    colmena
    btop
    psmisc
    jq
  ]) ++
  (with pkgs-stable;
  [
    # add
  ]);

  time.timeZone = "Europe/Berlin";

  fonts.fontconfig.useEmbeddedBitmaps = true;
  fonts.packages = with pkgs; [
    nerd-fonts.geist-mono
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.adwaita-mono
  ];

  imports = [
    # ./fprint.nix
    ./locale.nix
    # ./clamav.nix
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

  users.users.ad = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" "audio" ];
    uid = 1000;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG2bj+JgXVQ+9r8UA0zpBn2cx1DhffMIJXb3tF8ClSm1 ad"
    ];
  };
  security.sudo.wheelNeedsPassword = false;
}
