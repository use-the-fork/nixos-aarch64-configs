{lib, ...}: let
  inherit (lib) mkEnableOption mkOption types;
in {
  options.my.system.programs = {
    gui.enable = mkEnableOption "GUI package sets" // {default = true;};
    cli.enable = mkEnableOption "CLI package sets" // {default = true;};
    dev.enable = mkEnableOption "development related package sets";

  };
}
