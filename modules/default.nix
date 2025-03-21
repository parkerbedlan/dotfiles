{
  inputs,
  ...
}:

{
  imports = [
    ./basics
    inputs.home-manager.nixosModules.default
    ./users.nix
    ./stylix.nix
    ./graphics.nix
    ./startup.nix
    ./packages.nix
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "pk" = import ./home;
    };
    backupFileExtension = "backup";
  };

  environment.variables = {
    EDITOR = "nixCats";
    NIXPKGS_ALLOW_UNFREE = 1;
    LANG = "en_US.UTF-8";
  };

  system.stateVersion = "24.11"; # do not change
}
