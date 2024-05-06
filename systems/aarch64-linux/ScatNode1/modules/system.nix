{
  config.modules.system = {
    mainUser = "nerd";
    fs = ["ext4" "vfat" "ntfs" "exfat"];
    autoLogin = false;

    boot = {
      loader = "none";
      enableKernelTweaks = true;
      initrd.enableTweaks = true;
      tmpOnTmpfs = false;
    };

    video.enable = false;
    sound.enable = false;
    bluetooth.enable = false;
    printing.enable = false;
    emulation.enable = false;

    virtualization.enable = false;

    networking = {
      optimizeTcp = true;
      nftables.enable = true;
    };

    security = {
      fixWebcam = false;
      lockModules = true;
      auditd.enable = true;
    };
  };
}
