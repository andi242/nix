# https://github.com/fresh2dev/zellij-autolock
# https://github.com/h1romas4/zellij-datetime

{ fetchurl, ... }:
let
  plugins = {
    autolock = builtins.fetchurl {
      url = "https://github.com/fresh2dev/zellij-autolock/releases/download/0.2.2/zellij-autolock.wasm";
      sha256 = "sha256-aclWB7/ZfgddZ2KkT9vHA6gqPEkJ27vkOVLwIEh7jqQ=";
    };

    zjstatus = builtins.fetchurl {
      url = "https://github.com/dj95/zjstatus/releases/download/v0.20.2/zjstatus.wasm";
      sha256 = "sha256-OSg7Q1AWKW32Y9sHWJbWOXWF1YI5mt0N4Vsa2fcvuNg=";
    };
  };
  # to check sha256, move block down and rm 'builtins.', then run:
  #  nix-build -E 'with import <nixpkgs>  {}; callPackage ./default.nix {}'
in
{
  xdg.configFile."zellij/plugins/zellij-autolock.wasm".source = plugins.autolock;
  xdg.configFile."zellij/plugins/zjstatus.wasm".source = plugins.zjstatus;

  # dtime = builtins.fetchurl {
  #   url = "https://github.com/h1romas4/zellij-datetime/releases/download/v0.21.0/zellij-datetime.wasm";
  #   sha256 = "sha256-oVMh3LlFe4hcY9XmcEHz8pmodyf1aMvgDH31QEusEEE=";
  # };
}
