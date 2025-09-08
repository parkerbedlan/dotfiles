{
  ...
}:

{
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
          address = "192.168.4.145";
          prefixLength = 24;
        }
      ];
    };
    defaultGateway = "192.168.4.1";
    nameservers = [
      "192.168.4.1"
      "8.8.8.8"
    ];
  };
  boot.kernel.sysctl."net.ipv4.ip_forward" = true;

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
          destination = "192.168.4.145:8080"; # Replace with your LAN IP and port
          # destination = "0.0.0.0:8080"; # Replace with your LAN IP and port
          proto = "tcp";
        }
        {
          sourcePort = 2283;
          destination = "192.168.4.145:2283";
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
