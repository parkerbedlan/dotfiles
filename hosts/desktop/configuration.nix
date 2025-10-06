{
  pkgs,
  pkgs-stable,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    # ../laptop/networking.nix
    ../../modules/steam.nix
    ../../modules/graphics.nix
  ];

  home-manager.users.pk.host = "desktop";
  networking.hostName = "nixos-desktop";

  environment.variables = {
    HOST = "desktop";
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  environment.systemPackages = with pkgs; [
    ollama-rocm
    # virtualbox
    distrobox
    blender-hip
    rocmPackages.rocminfo
    rocmPackages.rocm-smi
    immich-go
    shotcut
    kdePackages.kdenlive
  ];
  # ++ (with pkgs-stable; [
  # doesn't seem to play nice with amd, idk. using an open source solution instead (shotcut or kdenlive)
  #   davinci-resolve
  # ]);

  # hosting immich
  # https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=services.immich.
  services.immich = {
    enable = true;
    port = 2283;
    host = "0.0.0.0";
    openFirewall = true;
    accelerationDevices = null;
    # settings.server.externalDomain = "https://immich.example.com";
    machine-learning.enable = true;
  };
  users.users.immich.extraGroups = [
    "video"
    "render"
  ];

  # hosting open-webui
  services.open-webui = {
    package = pkgs-stable.open-webui;
    enable = true;
    environment = {
      ANONYMIZED_TELEMETRY = "False";
      DO_NOT_TRACK = "True";
      SCARF_NO_ANALYTICS = "True";
      # TODO: make sure ollama also starts automatically
      OLLAMA_API_BASE_URL = "http://127.0.0.1:11434/api";
      OLLAMA_BASE_URL = "http://127.0.0.1:11434";
    };
    host = "0.0.0.0";
    openFirewall = true;
  };
}
