{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

  outputs = { nixpkgs, ... }@inputs: 
  let
    myNixCats = import ./nvim { inherit inputs; };
  in {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        inputs.stylix.nixosModules.stylix
      ];
    };

    # packages.x86_64-linux.default = myNixCats.nixCats;
    packages.x86_64-linux.default = myNixCats.packages.x86_64-linux.nixCats;
  };
}
