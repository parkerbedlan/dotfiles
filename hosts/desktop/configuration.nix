{
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/steam.nix
  ];

  home-manager.users.pk.host = "desktop";

  environment.variables = {
    HOST = "desktop";
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  environment.systemPackages = with pkgs; [
    ollama-rocm
    davinci-resolve
    virtualbox
    distrobox
    # haven't been able to get this to run yet (command: `fah-client`
    # fahclient
    # clinfo
    # rocmPackages.clr
    # ocl-icd
    # gpu-viewer
  ];
}
