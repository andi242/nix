# nix

neuer versuch...

`nix flake update` - update flake.lock  
`sudo nixos-rebuild switch --flake .#<system>` - rebuild system


`sudo nixos-rebuild switch --upgrade --flake ./nix/system#nixos-pc`  
`home-manager switch --flake ./nix/home-manager#ad`  

## nh

- `nh os switch --update` - with env var $FLAKE
- `nh home switch ~/gits/nix/home-manager -c ad --update` - home-manager
- `nh clean all --keep 5` - gc

## todo

- bundle home/system in one flake for update both at once
