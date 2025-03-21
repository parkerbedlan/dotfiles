{ ... }:
{
  # https://wiki.nixos.org/wiki/Zoxide
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    options = [ "--cmd cd" ];
  };
}
