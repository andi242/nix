{ pkgs, inputs, ... }:
{
  services.hardware.openrgb.enable = true;
  services.hardware.openrgb.motherboard = "amd";
  # services.hardware.openrgb.package = pkgs.openrgb.overrideAttrs (old: {
  #   version = "1.0rc1";
  #   src = pkgs.fetchFromGitLab {
  #     owner = "CalcProgrammer1";
  #     repo = "OpenRGB";
  #     rev = "release_candidate_1.0rc1";
  #     sha256 = "sha256-jKAKdja2Q8FldgnRqOdFSnr1XHCC8eC6WeIUv83e7x4=";
  #   };
  #   postPatch = ''
  #     patchShebangs scripts/build-udev-rules.sh
  #     substituteInPlace scripts/build-udev-rules.sh \
  #       --replace-fail /usr/bin/env "${pkgs.coreutils}/bin/env"
  #   '';
  # });
  hardware = {
    i2c = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    i2c-tools
    liquidctl
    fanctl
    openrgb-with-all-plugins
    # pkgs.openrgb-plugin-hardwaresync
    # pkgs.openrgb-plugin-effects
    # pkgs.openrgb-with-all-plugins
    # (pkgs.openrgb-with-all-plugins.overrideAttrs (old: {
    #   version = "1.0rc1";
    #   src = pkgs.fetchFromGitLab {
    #     owner = "CalcProgrammer1";
    #     repo = "OpenRGB";
    #     rev = "release_candidate_1.0rc1";
    #     sha256 = "sha256-jKAKdja2Q8FldgnRqOdFSnr1XHCC8eC6WeIUv83e7x4=";
    #   };
    #   postPatch = ''
    #     patchShebangs scripts/build-udev-rules.sh
    #     substituteInPlace scripts/build-udev-rules.sh \
    #       --replace-fail /usr/bin/env "${pkgs.coreutils}/bin/env"
    #   '';
    # }))
  ];
  systemd.services.openrgb.after = [ "network.target" ];
  systemd.services.openrgb.wants = [ "dev-usb.device" ];
}
