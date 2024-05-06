{
  description = "NixOS configuration";

  # ISO images based on available hosts. We avoid basing ISO images
  # on active (i.e. desktop) hosts as they likely have secrets set up.
  # Images below are designed specifically to be used as live media
  # and can be built with `nix build .#images.<hostname>`
  # alternatively hosts can be built with `nix build .#nixosConfigurations.hostName.config.system.build.isoImage`

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Powered By
    snowfall-lib = {
      url = "github:snowfallorg/lib/dev";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #Delrative Flatpaks
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.4.1";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware";

    #Shhhhhhh it's a secret.
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Generate System Images
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devshell.url = "github:numtide/devshell";

    #Handy for managing FS
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs: (inputs.snowfall-lib.mkFlake {
    inherit inputs;
    src = ./.;

    imports = [
      inputs.pre-commit-hooks.flakeModule
      inputs.treefmt-nix.flakeModule
    ];

    systems.modules.nixos = with inputs; [
      #pins stave version across all systems
      ({lib, ...}: {system.stateVersion = "24.05";})

      home-manager.nixosModules.home-manager

      #Sops everywhere!
      sops-nix.nixosModules.sops

      #generators everywhere!
      nixos-generators.nixosModules.all-formats

      #disko for disk setup
      disko.nixosModules.disko
    ];

    snowfall = {namespace = "my";};
    channels-config = {
      allowUnfree = true;
    };
    outputs-builder = channels: {
      formatter = channels.nixpkgs.alejandra;
    };
    alias.shells = {
      default = "default";
    };
  });

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };
}
