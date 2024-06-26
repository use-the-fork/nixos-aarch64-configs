{lib, ...}: let
  inherit (import ./helpers/fs.nix {inherit lib;}) getSecretFile getSharedModule getSSHKeyFiles;
  inherit (import ./helpers/types.nix {inherit lib;}) boolToNum;
  inherit (import ./helpers/themes.nix {inherit lib;}) serializeTheme compileSCSS;
  inherit (import ./helpers/mkModule.nix {inherit lib;}) mkModule;
  inherit (import ./services.nix {inherit lib;}) mkGraphicalService mkHyprlandService;
  inherit (import ./validators.nix {inherit lib;}) ifTheyExist ifGroupsExist isAcceptedDevice isWayland ifOneEnabled;
in {
  inherit getSecretFile getSharedModule getSSHKeyFiles;
  inherit boolToNum;
  inherit serializeTheme compileSCSS;
  inherit mkModule;
  inherit mkGraphicalService mkHyprlandService;
  inherit ifTheyExist ifGroupsExist isAcceptedDevice isWayland ifOneEnabled;

}
