{ ... }:
{
  # gaming mouse
  services.ratbagd.enable = true;

  # Enable touchpad support
  services.libinput.enable = true;
  services.libinput.touchpad.naturalScrolling = true;
  # use this to change touchpad scroll speed: services.libinput.touchpad.accelPointsScroll
}
