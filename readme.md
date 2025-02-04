# nix

neuer versuch...

`nix flake update` - update flake.lock  
`sudo nixos-rebuild switch --flake .#<system>` - rebuild system

`home-manager switch --flake ./nix/home-manager#ad`
`sudo nixos-rebuild switch --upgrade --flake ./nix/system#nixos-pc`
