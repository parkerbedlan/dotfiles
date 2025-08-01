{
  inputs,
  lib,
  ...
}:

{
  imports = [
    ./basics
    inputs.home-manager.nixosModules.default
    ./users.nix
    ./stylix.nix
    ./startup.nix
    ./packages.nix
    ./docker.nix
    ./hosts_file.nix
  ] ++ lib.optional (builtins.pathExists ./foo.nix) ./foo.nix;

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

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  system.stateVersion = "24.11"; # do not change
}
