{
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  home-manager.users.pk.host = "desktop";

  environment.variables = {
    HOST = "desktop";
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  environment.systemPackages = with pkgs; [
    ollama
  ];
}
