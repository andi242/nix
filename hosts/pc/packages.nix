{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nvtopPackages.amd
    libcamera # wireplumber might want it
  ];
}
