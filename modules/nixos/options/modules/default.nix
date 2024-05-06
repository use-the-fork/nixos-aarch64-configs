{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  options.my.modules = {
    iso = mkEnableOption "ISO";
    server = mkEnableOption "Server";
    headless = mkEnableOption "Headless";
    graphical = mkEnableOption "Graphical";
    workstation = mkEnableOption "Workstation";
    laptop = mkEnableOption "Laptop";
    microvm = mkEnableOption "MicroVM";
  };
}
