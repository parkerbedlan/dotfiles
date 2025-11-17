{
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ./battery.nix
    ../../modules/steam.nix
  ];

  home-manager.users.pk.host = "laptop";
  networking.hostName = "nixos-laptop";

  environment.variables = {
    HOST = "laptop";
  };

  # https://github.com/NixOS/nixos-hardware/blob/master/hp/laptop/14s-dq2024nf/default.nix
  # https://github.com/NixOS/nixos-hardware/blob/master/common/pc/ssd/default.nix
  services.fstrim.enable = true;

  # TODO
  # https://github.com/NixOS/nixos-hardware/blob/master/common/pc/default.nix
  # boot.blacklistedKernelModules = lib.optionals (!config.hardware.enableRedistributableFirmware) [
  #   "ath3k"
  # ];
  # TODO
  # https://github.com/NixOS/nixos-hardware/blob/master/common/pc/laptop/default.nix
}
