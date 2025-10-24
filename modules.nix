{ pkgs, config, lib, ... }:
{
  imports = map (f: ./modules/${f}) (builtins.attrNames (builtins.readDir ./modules));
}
