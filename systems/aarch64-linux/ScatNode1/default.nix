
{ pkgs, lib, inputs, ... }: {
  imports = [
  	inputs.nixos-hardware.nixosModules.raspberry-pi-4
  	./fs
  	./modules
  	./system.nix
  ];
}
