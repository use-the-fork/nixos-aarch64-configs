{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;

    modules = config.my.modules;
    sys = config.my.system;
    cfg = sys.services.home-assistant;

in {
  config = mkIf (cfg.enable && modules.server) {
      services.home-assistant = {
       enable = true;
       extraComponents = [
			# Components required to complete the onboarding
         "esphome"
         "met"
         "radio_browser"
       ];
       config = {
       		http.server_port = cfg.settings.port;
          # Includes dependencies for a basic setup
          # https://www.home-assistant.io/integrations/default_config/
         default_config = {};
       };
      };
  };
}
