{
  ...
}:
{
  # `systemctl --user restart redshift` to reset without rebooting
  services.redshift = {
    enable = true;
    # 1000 is warmest, 25000 is coldest
    temperature = {
      day = 3700; # default 5500
      night = 2000; # default 3700
    };
  };
}
