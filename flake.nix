{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # https://nixos-and-flakes.thiscute.world/nixos-with-flakes/downgrade-or-upgrade-packages
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # https://github.com/nix-community/nur-combined/blob/main/repos/rycee/pkgs/firefox-addons/generated-firefox-addons.nix
    # nix flake show "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons"
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    # todo: according to the top of the comments in the template, it may want nixpkgs-unstable instead of nixos-unstable, so keep an eye on that
    # https://github.com/BirdeeHub/nixCats-nvim/blob/main/templates/nixExpressionFlakeOutputs/default.nix
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
  };

  outputs =
    { nixpkgs, nixpkgs-stable, ... }@inputs:
    let
      myNixCats = import ./modules/nvim { inherit inputs; };
    in
    {
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          pkgs-stable = import nixpkgs-stable {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
        };
        modules = [
          ./hosts/desktop/configuration.nix
          ./modules
          inputs.stylix.nixosModules.stylix
        ];
      };
      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          pkgs-stable = import nixpkgs-stable {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
        };
        modules = [
          ./hosts/laptop/configuration.nix
          ./modules
          inputs.stylix.nixosModules.stylix
        ];
      };

      # todo: potentially use ${pkgs.system} for both instead of hard coding the system?
      packages.x86_64-linux.default = myNixCats.packages.x86_64-linux.nixCats;
      packages.aarch64-linux.default = myNixCats.packages.aarch64-linux.nixCats;
    };
}
