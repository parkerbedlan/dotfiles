{
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  home-manager.users.pk.host = "laptop";

  environment.variables = {
    HOST = "laptop";
  };
}
