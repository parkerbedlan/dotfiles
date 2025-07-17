{
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/steam.nix
  ];

  home-manager.users.pk.host = "laptop";

  environment.variables = {
    HOST = "laptop";
  };
}
