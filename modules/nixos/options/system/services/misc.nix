{lib, ...}: let
  inherit (lib) mkEnableOption mkOption types;
  inherit (lib.my) mkModule;
in {
  options.my.system = {
    services = {
      flatpak = {
        enable = mkEnableOption "Flatpak";
        packages = mkOption {
          type = with types; listOf str;
          default = [];
          description = ''
            A list of packages that should be installed on the system.

          '';
        };
      };

		home-assistant = mkModule {
		  name = "Home Assistant";
		  port = 8123;
		};

      #
      #      nginx = mkModule {
      #        name = "Nginx";
      #        type = "webserver";
      #      };

      #      forgejo = mkModule {
      #        name = "Forgejo";
      #        type = "forge";
      #        port = 7000;
      #      };
    };
  };
}
