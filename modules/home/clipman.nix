{ pkgs, ... }:
{
  services.clipman.enable = true;

  home.packages = [ pkgs.wl-clipboard ];
}
