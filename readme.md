# nix

neuer versuch...

`nix flake update` - update flake.lock  
`sudo nixos-rebuild switch --upgrade --flake ./nix/system#nixos-pc`  

## nh

- `nh os switch --update` - with env var $FLAKE
- `nh clean all --keep 5` - gc

## vm

- `nixos-rebuild build-vm --flake .#nixos-vm`
- `./result/bin/run-nixos-vm-vm`
- `rm result nixos-vm.qcow2`

## todo
