{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    docker
  ];

  virtualisation.docker = {
    enable = true;
    # sudo systemctl start docker
    enableOnBoot = false;
    autoPrune.enable = true;
  };
}
