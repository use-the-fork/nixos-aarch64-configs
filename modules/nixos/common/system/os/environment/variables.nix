_: {
  # variables that I want to set globally on all systems
  config = {
    environment.variables = {
      FLAKE = "/home/nerd/.config/nyx";
      SSH_AUTH_SOCK = "/run/user/\${UID}/keyring/ssh";

      # editors
      EDITOR = "nano";
      VISUAL = "nano";
      SUDO_EDITOR = "nano";
    };
  };
}
