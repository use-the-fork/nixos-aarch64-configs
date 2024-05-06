{...}: {
  imports = [
    ./fstrim.nix
    ./logrotate.nix
    ./thermald.nix
    ./zram.nix
  ];
}
