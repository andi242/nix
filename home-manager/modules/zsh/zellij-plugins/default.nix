# https://github.com/fresh2dev/zellij-autolock/releases/download/0.2.2/zellij-autolock.wasm
# https://github.com/fresh2dev/zellij-autolock
# https://github.com/h1romas4/zellij-datetime/releases/download/v0.21.0/zellij-datetime.wasm
# https://github.com/h1romas4/zellij-datetime

{ fetchurl, ... }:
let
  autolock = builtins.fetchurl {
    url = "https://github.com/fresh2dev/zellij-autolock/releases/download/0.2.2/zellij-autolock.wasm";
    sha256 = "sha256-aclWB7/ZfgddZ2KkT9vHA6gqPEkJ27vkOVLwIEh7jqQ=";
  };
  dtime = builtins.fetchurl {
    url = "https://github.com/h1romas4/zellij-datetime/releases/download/v0.21.0/zellij-datetime.wasm";
    sha256 = "sha256-oVMh3LlFe4hcY9XmcEHz8pmodyf1aMvgDH31QEusEEE=";
  };
in
{
  xdg.configFile."zellij/plugins/zellij-autolock.wasm".source = autolock;
  xdg.configFile."zellij/plugins/zellij-datetime.wasm".source = dtime;
  # how to patch config?
}
