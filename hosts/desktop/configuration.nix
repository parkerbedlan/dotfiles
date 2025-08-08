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
  networking.hostName = "nixos-desktop";

  environment.variables = {
    HOST = "desktop";
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  environment.systemPackages = with pkgs; [
    ollama-rocm
    # infinite loading, never downloads, needs a different version of nixpkgs
    # davinci-resolve
    # virtualbox
    distrobox
    blender-hip
    rocmPackages.rocminfo
    rocmPackages.rocm-smi
  ];

  # general hosting stuff
  networking = {
    interfaces.eth0.ipv4.addresses = [
      {
        address = "192.168.1.2";
        prefixLength = 24;
      }
    ];
  };
  boot.kernel.sysctl."net.ipv4.ip_forward" = true;

  # hosting open-webui on localhost:8080
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
  networking = {
    nat = {
      enable = true;
      internalInterfaces = [ "lo" ]; # Loopback interface
      externalInterface = "wlp9s0"; # Replace with your LAN interface name
      forwardPorts = [
        {
          sourcePort = 8080;
          destination = "192.168.7.143:8080"; # Replace with your LAN IP and port
          # destination = "0.0.0.0:8080"; # Replace with your LAN IP and port
          proto = "tcp";
        }
      ];
    };
    nftables.enable = true; # Enables nftables for NAT
    firewall.allowedTCPPorts = [ 8080 ];
  };

}
