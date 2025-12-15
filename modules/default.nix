{
  inputs,
  lib,
  pkgs,
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
    ./redshift.nix
  ]
  ++ lib.optional (builtins.pathExists ./foo.nix) ./foo.nix;

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

  # todo: figure out how to actually use this by looking through https://github.com/nix-community/nix-ld
  # until then, it seems like `nix-shell -p steam-run --run "steam-run ./hello-world"` works fine (I aliased it as `sr "./hello-world"`)
  programs.nix-ld = {
    enable = true;
    # libraries = with pkgs; [
    # ];
  };

  system.stateVersion = "24.11"; # do not change
}
