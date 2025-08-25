{ ... }:
{
  networking.extraHosts = ''
    # 0.0.0.0 youtube.com
    # 0.0.0.0 www.youtube.com
    192.168.7.143 ai.lo
    192.168.7.143 immich.lo
  '';
}
