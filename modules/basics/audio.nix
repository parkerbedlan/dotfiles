{ pkgs, ... }:
{
  services.pulseaudio = {
    enable = false;
    support32Bit = true;
  };
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber = {
      enable = true;
      # uncomment this if dealing with headphones that constantly switch to hfp/hsp mode
      extraConfig = {
        "10-bluez"."monitor.bluez.properties" = {
          "bluez5.hfphsp-backend" = "none";
        };
      };
    };
  };
  # hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # idk
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
      package = pkgs.bluez5-experimental;
      settings = {
        General = {
          AutoConnect = "true";
          FastConnectable = "true";
        };
        Policy = {
          AutoEnable = "false";
        };
      };
    };
    enableAllFirmware = true;
  };
}
