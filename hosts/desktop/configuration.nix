{
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/steam.nix
    ../../modules/graphics.nix
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
    blender-hip
    rocmPackages.rocminfo
    rocmPackages.rocm-smi
    # haven't been able to get this to run yet (command: `fah-client`
    # fahclient
    # clinfo
    # rocmPackages.clr
    # ocl-icd
    # gpu-viewer
  ];

  # programs.nix-ld = {
  #   enable = true;
  #   libraries = with pkgs; [
  #   ];
  # };

  # hosted on localhost:8080
  services.open-webui = {
    package = pkgs.open-webui; # pkgs must be from stable, for example nixos-24.11
    enable = true;
    environment = {
      ANONYMIZED_TELEMETRY = "False";
      DO_NOT_TRACK = "True";
      SCARF_NO_ANALYTICS = "True";
      OLLAMA_API_BASE_URL = "http://127.0.0.1:11434/api";
      OLLAMA_BASE_URL = "http://127.0.0.1:11434";
    };
    host = "0.0.0.0";
    openFirewall = true;
  };
  # hosting on lan
  boot.kernel.sysctl."net.ipv4.ip_forward" = true;
  networking = {
    nat = {
      enable = true;
      internalInterfaces = [ "lo" ]; # Loopback interface
      externalInterface = "wlp9s0"; # Replace with your LAN interface name
      forwardPorts = [
        {
          sourcePort = 8080;
          destination = "192.168.7.21:8080"; # Replace with your LAN IP and port
          # destination = "0.0.0.0:8080"; # Replace with your LAN IP and port
          proto = "tcp";
        }
      ];
    };
    nftables.enable = true; # Enables nftables for NAT
  };
  networking.firewall.allowedTCPPorts = [ 8080 ];

}
