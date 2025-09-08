{ ... }:
{
  networking.extraHosts = ''
    # 0.0.0.0 youtube.com
    # 0.0.0.0 www.youtube.com
    192.168.4.145 ai.lo
    192.168.4.145 immich.lo
  '';
}
