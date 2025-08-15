{
  pkgs,
  pkgs-stable,
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

  environment.systemPackages =
    with pkgs;
    [
      ollama-rocm
      # virtualbox
      distrobox
      blender-hip
      rocmPackages.rocminfo
      rocmPackages.rocm-smi
      immich-go
    ]
    ++ (with pkgs-stable; [
      davinci-resolve
    ]);

  # hosting immich
  # https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=services.immich.
  services.immich = {
    enable = true;
    port = 2283;
    host = "0.0.0.0";
    openFirewall = true;
    accelerationDevices = null;
    # settings.server.externalDomain = "https://immich.example.com";
  };
  users.users.immich.extraGroups = [
    "video"
    "render"
  ];

  networking = {
    networkmanager.enable = false;
    wireless = {
      enable = true;
      # actual wifi passwords in foo.nix
      # networks = {
      #   "<wifi-name-here>" = {
      #     psk = "<wifi-password-here>";
      #   };
      # };
    };
    interfaces.wlp9s0 = {
      useDHCP = false;
      ipv4.addresses = [
        {
          address = "192.168.7.143";
          prefixLength = 24;
        }
      ];
    };
    defaultGateway = "192.168.7.1";
    nameservers = [
      "192.168.7.1"
      "8.8.8.8"
    ];
  };
  boot.kernel.sysctl."net.ipv4.ip_forward" = true;

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

  # hosting on lan
  networking = {
    nftables.enable = true; # Enables nftables for NAT
    nat = {
      enable = true;
      internalInterfaces = [ "lo" ]; # Loopback interface
      externalInterface = "wlp9s0"; # LAN interface name
      forwardPorts = [
        {
          sourcePort = 8080;
          destination = "192.168.7.143:8080"; # Replace with your LAN IP and port
          # destination = "0.0.0.0:8080"; # Replace with your LAN IP and port
          proto = "tcp";
        }
        {
          sourcePort = 2283;
          destination = "192.168.7.143:2283";
          proto = "tcp";
        }
      ];
    };
    firewall.allowedTCPPorts = [
      8080
      2283
    ];
  };

}
