{
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/steam.nix
  ];

  home-manager.users.pk.host = "laptop";
  networking.hostName = "nixos-laptop";

  environment.variables = {
    HOST = "laptop";
  };
}
