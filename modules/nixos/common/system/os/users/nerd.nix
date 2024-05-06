{pkgs, ...}: let
  keys = [
      # Ubuntu key
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAXXUIUO43Ta9R0vdYb8mRxh1tGpD8b5ExnE3y8XwuCV nurd"
      # NixOS key
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOAMRygHsDzFOKXtfuiufsRiLtg4Er4R8cElBB9p/etk nerd"
  ];
in {
  config = {
    boot.initrd.network.ssh.authorizedKeys = keys;

    services.openssh = {
      enable = true;
      openFirewall = true;
      hostKeys = [
        {
          bits = 4096;
          path = "/etc/ssh/ssh_host_rsa_key";
          type = "rsa";
        }
        {
          path = "/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
      ];
    };

    users.users.nerd = {
      isNormalUser = true;
      shell = pkgs.zsh;
      hashedPassword = "$6$ajR1NvGqtfgQJK1P$uexjrejIRcZsy2u2HZr.ZZ26nTLcRFy1lmRl591LxUyxdHvb.VBSQ.ndFEsczTO>";
      openssh.authorizedKeys.keys = keys;
      extraGroups = [
        "wheel"
        "gitea"
        "docker"
        "systemd-journal"
        "vboxusers"
        "audio"
        "plugdev"
        "video"
        "input"
        "lp"
        "networkmanager"
        "power"
        "nix"
      ];
      uid = 1000;
    };
  };
}
