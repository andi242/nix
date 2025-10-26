{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bat
    btop
    colmena
    curl
    duf
    ffmpeg-full
    fontconfig
    fzf
    gcc
    git
    home-manager
    jq
    lazygit
    lazygit
    nvtopPackages.amd
    openssl
    pciutils
    psmisc
    sops
    tree
    unzip
    usbutils
    wget
  ];
  programs.nix-ld.enable = true; # for precompiled binaries
  documentation.doc.enable = false; # no html docs
}
