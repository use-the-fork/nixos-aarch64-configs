
{ pkgs, lib, inputs, ... }: {
  imports = [ inputs.nixos-hardware.nixosModules.raspberry-pi-4 ];
  TM = {
    laptop = true;
    autoUpgrade.enable = false;
  };
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };
  boot = {
    consoleLogLevel = lib.mkDefault 7;
    # The serial ports listed here are:
    # - ttyS0: for Tegra (Jetson TX1)
    # - ttyAMA0: for QEMU's -machine virt
    initrd.availableKernelModules = [
      "bcm2835_dma"
      "i2c_bcm2835"
      # Allows early (earlier) modesetting for Allwinner SoCs
      "sun4i_drm"
      "sun8i_drm_hdmi"
      "sun8i_mixer"
      # Allows early (earlier) modesetting for the Raspberry Pi
      "vc4"
    ];
    initrd.systemd.enable = false;
    kernelPackages = pkgs.linuxPackages_rpi4;
    kernelParams =
      [ "console=ttyS0,115200n8" "console=ttyAMA0,115200n8" "console=tty0" ];
    loader.generic-extlinux-compatible.enable = true;
    loader.grub.enable = false;
  };
  networking = {
    networkmanager.enable = true;
    wireless.enable = false;
  };
  nixpkgs = {
    localSystem.system = "aarch64-linux";
    # Fix missing modules
    # https://github.com/NixOS/nixpkgs/issues/154163
    overlays = [
      (_final: super: {
        makeModulesClosure = x:
          super.makeModulesClosure (x // { allowMissing = true; });
      })
    ];
  };
  programs = {
    starship.enable = true;
    mosh.enable = true;
  };
  services = {
    openssh.enable = true;
    thermald.enable = false;
  };

}
