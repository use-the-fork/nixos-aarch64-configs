{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkForce mapAttrs mkIf;
in {
	config = mkIf config.my.modules.headless {
		  xdg = mapAttrs (_: mkForce) {
			sounds.enable = false;
			mime.enable = false;
			menus.enable = false;
			icons.enable = false;
			autostart.enable = false;
		  };
	  };
}
