{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkOption types mkEnableOption;
  cfg = config.my.style;
in {
  options = {
    my = {
      style = {
        qt = {
          enable = mkEnableOption "QT Style Module";

          theme = {
            package = mkOption {
              type = types.package;
              default = pkgs.catppuccin-kde.override {
                flavour = ["mocha"];
                accents = ["blue"];
                winDecStyles = ["modern"];
              };
              description = "The theme package to be used for QT programs";
            };

            name = mkOption {
              type = types.str;
              default = "Catppuccin-Mocha-Dark";
              description = "The name for the QT theme package";
            };
          };

          kdeglobals.source = mkOption {
            type = types.path;
            default = "${cfg.qt.theme.package}/share/color-schemes/CatppuccinMochaBlue.colors";
            description = "The source file for the kdeglobals file. Usually provided by the qt theme package";
          };
        };
      };
    };
  };
}
