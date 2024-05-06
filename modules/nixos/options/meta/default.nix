{
  config,
  lib,
  ...
}: let
  inherit (lib) types;
  inherit (lib.options) mkOption;

  env = config.my.usrEnv;
in {
  options.my.meta = {
    hostname = mkOption {
      type = types.str;
      default = config.networking.hostName;
      readOnly = true;
      description = ''
        The canonical hostname of the machine.

        Is usually used to identify - i.e name machines internally
        or on the same Headscale network. This option must be declared
        in `hosts.nix` alongside host system.
      '';
    };

    system = mkOption {
      type = types.str;
      default = config.system.build.toplevel.system;
      readOnly = true;
      description = ''
        The architecture of the machine.
      '';
    };
  };
}
